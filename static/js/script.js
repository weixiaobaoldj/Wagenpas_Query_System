$(document).ready(function() {
    // 清除按钮
    $('#clearBtn').click(function() {
        $('#vin_or_mix').val('');
        $('#rhfdtyp_2').val('');
        $('#resultContainer').hide();
        $('#errorContainer').hide().empty();
    });
    
    // 在线查询
    $('#onlineQuery').click(function() {
        executeQuery('online');
    });
    
    // 离线查询
    $('#offlineQuery').click(function() {
        executeQuery('offline');
    });
    
    // 文件点击事件
    $(document).on('click', '.file-item', function() {
        const url = $(this).data('url');
        const zipUrl = $(this).data('zip-url');
        const filename = $(this).data('filename');
        const isPDF = filename.toLowerCase().endsWith('.pdf');
		
        let viewUrl = '/view_file?url=' + encodeURIComponent(url || '');
    
        if (zipUrl && filename) {
            viewUrl += '&zip_url=' + encodeURIComponent(zipUrl);
            viewUrl += '&filename=' + encodeURIComponent(filename);
        }
        // PDF文件在新标签页打开
        if (isPDF) {
            window.open(viewUrl, '_blank');
        } else {
            // 其他文件类型使用原处理方式
            window.open(viewUrl, '_blank');
    }
    });
});

function executeQuery(queryType) {
    // 显示加载中
    $('#loading').show();
    $('#resultContainer').hide();
    $('#errorContainer').hide().empty();
    
    // 获取表单数据
    const formData = {
        vin_or_mix: $('#vin_or_mix').val(),
        query_type: queryType,
        rhfdtyp_2: $('#rhfdtyp_2').val()
    };
    
    // 发送查询请求
    $.ajax({
        url: '/query',
        type: 'POST',
        data: formData,
        success: function(response) {
            $('#loading').hide();
            
            if (response.status === 'error') {
                if (response.require_confirm) {
                    showConfirmDialog(response.message);
                } else {
                    showError(response.message);
                }
            } else if (response.status === 'success') {
                // 进入步骤2
                executeStep2();
            }
        },
        error: function(xhr) {
            $('#loading').hide();
            showError('查询请求失败: ' + xhr.responseText);
        }
    });
}

function executeStep2() {
    $('#loading').show();
    
    $.ajax({
        url: '/step2',
        type: 'POST',
        success: function(response) {
            $('#loading').hide();
            
            if (response.status === 'error') {
                showError(response.message);
            } else if (response.status === 'success') {
                if (response.step === 3) {
                    // 进入步骤3
                    executeStep3(response.dir_url);
                } else if (response.step === 4) {
                    // 进入步骤4
                    executeStep4(response.zip_url);
                }
            }
        },
        error: function(xhr) {
            $('#loading').hide();
            showError('步骤2请求失败: ' + xhr.responseText);
        }
    });
}

function executeStep3(dirUrl) {
    $('#loading').show();
    
    $.ajax({
        url: '/step3',
        type: 'POST',
        data: { dir_url: dirUrl },
        success: function(response) {
            $('#loading').hide();
            
            if (response.status === 'error') {
                showError(response.message);
            } else if (response.status === 'success') {
                displayFileList(response.files, response.base_url);
            }
        },
        error: function(xhr) {
            $('#loading').hide();
            showError('步骤3请求失败: ' + xhr.responseText);
        }
    });
}

function executeStep4(zipUrl) {
    $('#loading').show();
    
    $.ajax({
        url: '/step4',
        type: 'POST',
        data: { zip_url: zipUrl },
        success: function(response) {
            $('#loading').hide();
            
            if (response.status === 'error') {
                showError(response.message);
            } else if (response.status === 'success') {
                displayFileList(response.files, null, response.zip_url);
            }
        },
        error: function(xhr) {
            $('#loading').hide();
            showError('步骤4请求失败: ' + xhr.responseText);
        }
    });
}

function displayFileList(files, baseUrl, zipUrl) {
    const $fileList = $('#fileList').empty();
    
    if (files.length === 0) {
        showError('没有找到匹配的文件');
        return;
    }
    
    files.forEach(function(file) {
        const isPDF = file.toLowerCase().endsWith('.pdf');
        const fileIcon = isPDF ? '<i class="fas fa-file-pdf text-danger me-2"></i>' : '';
        
        const fullUrl = baseUrl ? baseUrl + file : '';
        const $item = $(`
            <a href="#" class="list-group-item list-group-item-action file-item">
                ${fileIcon}${file}
            </a>
        `)
        .data('url', fullUrl)
        .data('filename', file);
        
        if (zipUrl) {
            $item.data('zip-url', zipUrl);
        }
        
        $fileList.append($item);
    });
    
    $('#resultContainer').show();
}
function showError(message) {
    $('#errorContainer').text(message).show();
}

function showConfirmDialog(message) {
    $('#confirmMessage').text(message);
    const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
    modal.show();
}