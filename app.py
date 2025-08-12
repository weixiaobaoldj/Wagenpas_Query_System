import os
import re
import cx_Oracle
import requests
import zipfile
from io import BytesIO
from flask import Flask, render_template, request, jsonify, send_from_directory, abort, make_response
from bs4 import BeautifulSoup
from lxml import etree

app = Flask(__name__)

# 配置
BASE_URL = "http://ndc.daq.volvocars.net/Wagenpas/"
ORACLE_CONN_STR = "application/application@daqsvl1120.daq.volvocars.net:49951/DBDQDBIP_PRI"
XSLT_DIR = "C:\\Wagenpas_Query_System\\stylesheet"

# 全局变量存储查询状态
query_status = {
    'RHFDTYP_1': None,
    'ICHASSIS_1': None,
    'ICHASSIS_2': None
}

# VIN校验位计算
def calculate_vin_check_digit(vin):
    map = {
        'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5, 'F': 6, 'G': 7, 'H': 8,
        'J': 1, 'K': 2, 'L': 3, 'M': 4, 'N': 5, 'P': 7, 'R': 9,
        'S': 2, 'T': 3, 'U': 4, 'V': 5, 'W': 6, 'X': 7, 'Y': 8, 'Z': 9
    }
    weights = [8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2]
    sum = 0
    
    for i in range(17):
        char = vin[i]
        if char.isdigit():
            value = int(char)
        else:
            value = map.get(char.upper(), 0)
        sum += value * weights[i]
    
    remainder = sum % 11
    if remainder == 10:
        return 'X'
    else:
        return str(remainder)

# 检查VIN有效性
def is_valid_vin(vin):
    if len(vin) != 17:
        return False
    check_digit = calculate_vin_check_digit(vin)
    return vin[8] == check_digit

# 数据库查询
def query_database(vin_or_mix):
    try:
        conn = cx_Oracle.connect(ORACLE_CONN_STR)
        cursor = conn.cursor()
        
        if len(vin_or_mix) == 17:  # VIN
            query = "SELECT RHFDTYP, ICHASSIS FROM TBI040 WHERE IVIN = :1"
        else:  # MIX
            query = "SELECT RHFDTYP, ICHASSIS FROM TBI040 WHERE IVMIX = :1"
            
        cursor.execute(query, [vin_or_mix])
        result = cursor.fetchone()
        
        if result:
            rhfdtyp, ichassis = result
            query_status['RHFDTYP_1'] = rhfdtyp
            query_status['ICHASSIS_1'] = ichassis[1:4] if len(ichassis) >= 4 else ''
            query_status['ICHASSIS_2'] = ichassis[-6:] if len(ichassis) >= 6 else ''
            return True
        else:
            return False
            
    except Exception as e:
        print(f"数据库查询错误: {e}")
        return False
    finally:
        if 'conn' in locals():
            conn.close()

# 检查远程目录是否存在
def check_remote_dir_exists(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')
            return True
        return False
    except:
        return False

# 检查远程文件是否存在
def check_remote_file_exists(url):
    try:
        response = requests.head(url)
        return response.status_code == 200
    except:
        return False

# 获取远程目录内容
def get_remote_dir_contents(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')
            links = [a.get('href') for a in soup.find_all('a') if a.get('href') not in ['../']]
            return links
        return []
    except:
        return []

# 处理XML文件
def process_xml(content, filename):
    try:
        # 根据文件名确定XSLT模板
        if filename.upper().endswith("CCC.XML"):
            xslt_path = os.path.join(XSLT_DIR, "Ccc.xsl")
        elif filename.upper().endswith("INST.XML"):
            xslt_path = os.path.join(XSLT_DIR, "Installation.xsl")
        elif filename.lower().endswith("labels.xml"):
            xslt_path = os.path.join(XSLT_DIR, "label.xsl")
        elif filename.lower().endswith("inspectionreport.xml"):
            xslt_path = os.path.join(XSLT_DIR, "InspectionReport_GB18285_2018.xsl")
        elif filename.lower().endswith("clm.xml"):
            xslt_path = os.path.join(XSLT_DIR, "display_xml.xsl")
        else:
            xslt_path = os.path.join(XSLT_DIR, "Wagen.xsl")
        
        # 加载XSLT
        xslt = etree.parse(xslt_path)
        transform = etree.XSLT(xslt)
        
        # 解析XML
        xml = etree.fromstring(content)
        
        # 应用转换
        result = transform(xml)
        
        return str(result)
    except Exception as e:
        print(f"XML处理错误: {e}")
        return f"<html><body><h1>XML处理错误</h1><p>{str(e)}</p></body></html>"

# 路由
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/query', methods=['POST'])
def handle_query():
    global query_status
    query_status = {'RHFDTYP_1': None, 'ICHASSIS_1': None, 'ICHASSIS_2': None}
    
    vin_or_mix = request.form.get('vin_or_mix', '').strip()
    query_type = request.form.get('query_type')
    rhfdtyp_2 = request.form.get('rhfdtyp_2', '').strip()
    
    # 验证输入
    if not vin_or_mix:
        return jsonify({'status': 'error', 'message': 'VIN或MIX是必输项！'})
    
    if len(vin_or_mix) not in (7, 17):
        return jsonify({'status': 'error', 'message': 'VIN必须是17位，MIX必须是7位！'})
    
    # VIN校验
    if len(vin_or_mix) == 17 and not is_valid_vin(vin_or_mix):
        return jsonify({'status': 'error', 'message': '该VIN无效！请重新输入！！'})
    
    # 在线查询
    if query_type == 'online':
        if query_database(vin_or_mix):
            return jsonify({'status': 'success', 'step': 2})
        else:
            return jsonify({
                'status': 'error', 
                'message': '该VIN或MIX由于超过了离线数据库保存期限，已经在TBI040数据库中被清除了！如果要继续查询，只有在输入正确的VIN和选择合适的车型后，点击"离线查询"按钮进行查询！',
                'require_confirm': True
            })
    
    # 离线查询
    elif query_type == 'offline':
        if len(vin_or_mix) != 17:
            return jsonify({'status': 'error', 'message': '离线查询只能按VIN查询！！'})
        
        if not rhfdtyp_2:
            return jsonify({'status': 'error', 'message': '离线查询必须要选择合适的车型！'})
        
        # 赋值全局变量
        query_status['RHFDTYP_1'] = rhfdtyp_2[:3]
        query_status['ICHASSIS_1'] = vin_or_mix[11:14]
        query_status['ICHASSIS_2'] = vin_or_mix[-6:]
        
        return jsonify({'status': 'success', 'step': 2})
    
    return jsonify({'status': 'error', 'message': '未知查询类型！'})

@app.route('/step2', methods=['POST'])
def handle_step2():
    global query_status
    
    rhfdtyp_1 = query_status['RHFDTYP_1']
    ichassis_1 = query_status['ICHASSIS_1']
    
    if not rhfdtyp_1 or not ichassis_1:
        return jsonify({'status': 'error', 'message': '缺少必要参数！'})
    
    # 检查RHFDTYP_1目录
    rhfdtyp_url = f"{BASE_URL}{rhfdtyp_1}/"
    if not check_remote_dir_exists(rhfdtyp_url):
        return jsonify({'status': 'error', 'message': f'没有以 {rhfdtyp_1} 内容命名的目录存在！'})
    
    # 检查ICHASSIS_1目录
    ichassis_url = f"{rhfdtyp_url}{ichassis_1}/"
    if not check_remote_dir_exists(ichassis_url):
        return jsonify({'status': 'error', 'message': f'没有以 {ichassis_1} 内容命名的目录存在！'})
    
    # 检查ZIP文件
    zip_filename = f"{rhfdtyp_1}_{ichassis_1}.zip"
    zip_url = f"{ichassis_url}{zip_filename}"
    
    if check_remote_file_exists(zip_url):
        return jsonify({'status': 'success', 'step': 4, 'zip_url': zip_url})
    else:
        return jsonify({'status': 'success', 'step': 3, 'dir_url': ichassis_url})

@app.route('/step3', methods=['POST'])
def handle_step3():
    global query_status
    
    dir_url = request.form.get('dir_url')
    rhfdtyp_1 = query_status['RHFDTYP_1']
    ichassis_2 = query_status['ICHASSIS_2']
    
    if not dir_url or not rhfdtyp_1 or not ichassis_2:
        return jsonify({'status': 'error', 'message': '缺少必要参数！'})
    
    # 获取目录内容
    files = get_remote_dir_contents(dir_url)
    if not files:
        return jsonify({'status': 'error', 'message': '目录中没有文件！'})
    
    # 筛选符合条件的文件
    pattern = re.compile(f".*{rhfdtyp_1}.*{ichassis_2}.*", re.IGNORECASE)
    matched_files = [f for f in files if pattern.search(f)]
    
    if not matched_files:
        return jsonify({'status': 'error', 'message': '没有该VIN的数据存在！'})
    
    # 返回文件列表
    return jsonify({
        'status': 'success',
        'files': matched_files,
        'base_url': dir_url
    })

@app.route('/step4', methods=['POST'])
def handle_step4():
    global query_status
    
    zip_url = request.form.get('zip_url')
    rhfdtyp_1 = query_status['RHFDTYP_1']
    ichassis_2 = query_status['ICHASSIS_2']
    
    if not zip_url or not rhfdtyp_1 or not ichassis_2:
        return jsonify({'status': 'error', 'message': '缺少必要参数！'})
    
    try:
        # 下载ZIP文件
        response = requests.get(zip_url)
        if response.status_code != 200:
            return jsonify({'status': 'error', 'message': '无法下载ZIP文件！'})
        
        # 读取ZIP内容
        zip_content = BytesIO(response.content)
        matched_files = []
        
        with zipfile.ZipFile(zip_content) as z:
            # 筛选符合条件的文件
            pattern = re.compile(f".*{rhfdtyp_1}.*{ichassis_2}.*", re.IGNORECASE)
            matched_files = [f for f in z.namelist() if pattern.search(f)]
            
            if not matched_files:
                return jsonify({'status': 'error', 'message': '归档数据中没有该VIN的数据存在！'})
            
            # 返回文件列表
            return jsonify({
                'status': 'success',
                'files': matched_files,
                'zip_url': zip_url
            })
            
    except Exception as e:
        return jsonify({'status': 'error', 'message': f'处理ZIP文件时出错: {str(e)}'})

@app.route('/view_file', methods=['GET'])
def view_file():
    # 检查必需参数
    if not request.args.get('url') and not (request.args.get('zip_url') and request.args.get('filename')):
        abort(400, description="缺少必要的URL参数或ZIP文件参数")
    
    try:
        # 处理ZIP中的文件
        if 'zip_url' in request.args and 'filename' in request.args:
            zip_url = request.args.get('zip_url')
            filename = request.args.get('filename')
            
            if not zip_url or not filename:
                abort(400, description="缺少ZIP文件URL或文件名参数")
            
            # 下载ZIP文件
            response = requests.get(zip_url)
            if response.status_code != 200:
                abort(404, description="无法下载ZIP文件")
            
            # 读取ZIP内容
            zip_content = BytesIO(response.content)
            
            with zipfile.ZipFile(zip_content) as z:
                if filename not in z.namelist():
                    abort(404, description="文件不在ZIP中")
                
                # 读取文件内容
                with z.open(filename) as f:
                    content = f.read()
                    
                    # 根据文件类型处理
                    if filename.lower().endswith('.pdf'):
                        # 返回PDF文件下载
                        response = make_response(content)
                        response.headers['Content-Type'] = 'application/pdf'
                        response.headers['Content-Disposition'] = f'inline; filename={filename}'
                        return response                    
                    elif filename.lower().endswith('.xml'):
                        try:
                            processed_content = process_xml(content, filename)
                            return processed_content
                        except Exception as e:
                            print(f"XML处理错误: {e}")
                            return content, 200, {'Content-Type': 'application/xml'}
                    elif filename.lower().endswith('.html'):
                        return content, 200, {'Content-Type': 'text/html'}
                    else:
                        return content, 200, {'Content-Type': 'text/plain'}
        
        # 处理普通文件请求
        elif 'url' in request.args:
            file_url = request.args.get('url')
            if not file_url:
                abort(400, description="缺少文件URL参数")
            
            response = requests.get(file_url)
            if response.status_code != 200:
                abort(404, description="无法获取文件")
            
            content = response.content
            content_type = response.headers.get('Content-Type', 'text/plain')
            
            # 处理XML文件
            if file_url.lower().endswith('.xml'):
                try:
                    xml = etree.fromstring(content)
                    xslt = None
                    
                    # 查找XSLT引用
                    for pi in xml.xpath('//processing-instruction()'):
                        if pi.target == 'xml-stylesheet':
                            href = re.search(r'href=["\']([^"\']+)["\']', pi.text)
                            if href:
                                xslt_url = href.group(1)
                                if not xslt_url.startswith('http'):
                                    base_url = os.path.dirname(file_url) + '/'
                                    xslt_url = base_url + xslt_url
                                
                                xslt_response = requests.get(xslt_url)
                                if xslt_response.status_code == 200:
                                    xslt = etree.fromstring(xslt_response.content)
                    
                    if xslt:
                        transform = etree.XSLT(xslt)
                        result = transform(xml)
                        return str(result)
                    else:
                        return content, 200, {'Content-Type': content_type}
                except Exception as e:
                    print(f"XML处理错误: {e}")
                    return content, 200, {'Content-Type': content_type}
            # 添加PDF文件处理
            if file_url.lower().endswith('.pdf'):
                response = make_response(content)
                response.headers['Content-Type'] = 'application/pdf'
                response.headers['Content-Disposition'] = f'inline; filename={os.path.basename(file_url)}'
                return response            
            # 其他文件类型
            return content, 200, {'Content-Type': content_type}
            
    except Exception as e:
        abort(500, description=f"处理文件时出错: {str(e)}")
@app.errorhandler(400)
def bad_request(error):
    return jsonify({
        'status': 'error',
        'message': error.description if error.description else '错误的请求'
    }), 400

@app.errorhandler(404)
def not_found(error):
    return jsonify({
        'status': 'error',
        'message': error.description if error.description else '资源未找到'
    }), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify({
        'status': 'error',
        'message': error.description if error.description else '服务器内部错误'
    }), 500
@app.route('/readme')
def readme():
    readme_path = "C:\\Wagenpas_Query_System\\readme.html"
    if os.path.exists(readme_path):
        return send_from_directory(os.path.dirname(readme_path), os.path.basename(readme_path))
    else:
        abort(404, description="README文件不存在")

if __name__ == '__main__':
    # 确保XSLT目录存在
    if not os.path.exists(XSLT_DIR):
        os.makedirs(XSLT_DIR)
    
    # 运行应用
    app.run(host='0.0.0.0', port=5000, debug=True)