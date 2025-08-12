<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>
  
  <!-- 根模板 -->
  <xsl:template match="/">
    <html>
      <head>
        <title>XML 内容展示</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          .node { margin-left: 20px; border-left: 1px dotted #ccc; padding-left: 10px; }
          .tag { color: #800080; font-weight: bold; }
          .attr-name { color: #FF4500; }
          .attr-value { color: #0000FF; }
          .text { color: #000000; }
          .toggle { cursor: pointer; margin-right: 5px; }
          .collapsed > .children { display: none; }
        </style>
        <script>
          function toggleNode(element) {
            element.parentElement.classList.toggle("collapsed");
          }
        </script>
      </head>
      <body>
        <h1>XML 内容树状结构</h1>
        <xsl:apply-templates select="*"/>
      </body>
    </html>
  </xsl:template>

  <!-- 元素节点模板 -->
  <xsl:template match="*">
    <div class="node">
      <span class="toggle" onclick="toggleNode(this)">▼</span>
      <span class="tag">&lt;<xsl:value-of select="name()"/></span>
      <xsl:apply-templates select="@*"/>
      <span class="tag">&gt;</span>
      <div class="children">
        <xsl:apply-templates select="node()"/>
        <span class="tag">&lt;/<xsl:value-of select="name()"/>&gt;</span>
      </div>
    </div>
  </xsl:template>

  <!-- 属性节点模板 -->
  <xsl:template match="@*">
    <span class="attr-name"> <xsl:value-of select="name()"/>="</span>
    <span class="attr-value"><xsl:value-of select="."/></span>"
  </xsl:template>

  <!-- 文本节点模板 -->
  <xsl:template match="text()">
    <xsl:if test="normalize-space() != ''">
      <span class="text"><xsl:value-of select="normalize-space()"/></span>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>