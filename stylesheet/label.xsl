<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes">
	<xsl:template match="Label">
		<html>
			<head>
				<title>Label Data</title>
			</head>
			<body>
				<h6>
					<b>
						<center>CREATED: <xsl:value-of select="Datum"/>(YYYY/WW/D HH24:MI:SS)</center>
					</b>
				</h6>
				<br>
					<h1>
						<center>
							<u>Label data</u>
						</center>
					</h1>
				</br>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Datum"/>
	<xsl:template match="Eigenschappen" >
		<h2>
			<center>
				<i>General car data </i>
			</center>
		</h2>
		<br/> <b>Mixnummer: </b>
        <xsl:value-of select="Mixnummer" />
		<br/> <b>Fyon: </b>
        <xsl:value-of select="Fyonnummer" />		
		<br/> <b>Body: </b>
        <xsl:value-of select="Bodynummer" />
		<br/> <b>Maintype: </b>
        <xsl:value-of select="Hoofdtype" />
		<br/> <b>Chassis: </b>
        <xsl:value-of select="Chassis" />
		<br/> <b>Modelyear: </b>
        <xsl:value-of select="Modeljaar" />
		<br/> <b>Productionline: </b>
        <xsl:value-of select="Produktielijn" />		
	</xsl:template>
	
	<xsl:template match="Labels">
		<h2>
			<center>
				<i>Label data</i>
			</center>
		</h2>
		<xsl:for-each select="LabelData">
			<menu>
				<li type="disc">
					<u>Label</u>
					<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
						<thead style="font:bold; background-color:#C0C0C0">
							<tr>
								<th>Label</th>
								<th>Description</th>
							</tr>
						</thead>
						<tr>
							<td align="left">
								<xsl:value-of select="Label"/>
							</td>
							<td align="left">
								<xsl:value-of select="Omschrijving"/>
							</td>
						</tr>
					</table>
					<br/>
					<menu>
						<li type="circle">
							<u>Positions</u>
							<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
								<thead style="font:bold; background-color:#C0C0C0">
									<tr>
										<th>Position</th>
										<th>Description</th>
										<th>Value</th>
										<th>8Y-code</th>
										<th>BIS-item</th>
									</tr>
								</thead>
								<xsl:for-each select="Posities">
									<tr>
										<td align="left">
											<xsl:value-of select="Positie"/>
										</td>
										<td align="left">
											<xsl:value-of select="Omschrijving"/>
										</td>
										<td align="left">
											<xsl:value-of select="Waarde"/>
										</td>
										<td align="left">
											<xsl:value-of select="Label8YCode"/>
										</td>
										<td align="left">
											<xsl:value-of select="BisItem"/>
										</td>																				
									</tr>
								</xsl:for-each>
							</table>
						</li>
					</menu>
				</li>
			</menu>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

