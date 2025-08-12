<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="Installation">
        <html>
            <head>
                <title>Installation feedback data
                </title>
            </head>
            <body>
                <h6>
                    <b>
                        <center> CREATED: <xsl:value-of select="Date"/>
						</center>
						<center> <xsl:value-of select="Datum"/>(YYYY/WW/D HH24:MI:SS)
						</center>
                    </b>
                </h6>
                <br>
                    <h1>
                        <center>
                            <u>Installation feedback data
                            </u>
                        </center>
                    </h1>
                </br>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="Datum"/>
	<xsl:template match="Date"/>
    <xsl:template match="Properties" >
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
        <xsl:value-of select="Maintype" />
		<br/> <b>Chassis: </b>
        <xsl:value-of select="Chassis" />
		<br/> <b>Plant: </b>
        <xsl:value-of select="Plant" />
		<br/> <b>Modelyear: </b>
        <xsl:value-of select="Modelyear" />
		<br/> <b>Productionline: </b>
        <xsl:value-of select="Productionline" />		
	</xsl:template>
	
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
		<br/> <b>Plant: </b>
        <xsl:value-of select="Plant" />
		<br/> <b>Modelyear: </b>
        <xsl:value-of select="Modeljaar" />
		<br/> <b>Productionline: </b>
        <xsl:value-of select="Produktielijn" />		
	</xsl:template>
    <xsl:template match="Installaties">
    <h2>
      <center>
	<i>Installation feedback
	</i>
      </center>
    </h2>
    <xsl:for-each select="InstallatieData">
      <menu>
	<li type="disc">
	  <u>Installation
	  </u>
	  <table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
	    <thead style="font:bold; background-color:#C0C0C0">
	      <tr>
		<th>Installation
		</th>
		<th>Status
		</th>
		<xsl:if test="PopId!=' ' and PopId!='' ">
		  <th>POP id
		  </th>
		</xsl:if>
		<xsl:if test="PopTypeCode!=' ' and PopTypeCode!='' ">
		  <th>POPtype
		  </th>
		</xsl:if>
		<th>Parameterset
		</th>
		<th>Registration time
		</th>
		<th>Tool
		</th>
		<th>Calibration time
		</th>
		<th>Operator
		</th>
	      </tr>
	    </thead>
	    <tr>
	      <td align="left">
		<xsl:value-of select="Installatie"/>
	      </td>
		<xsl:choose>
		  <xsl:when test="(Status='OK ') or (Status='OK') or (Status = 'OK-NA')">
			<td align="left" bgcolor="#008000">
				<xsl:value-of select="Status"/>
			</td>
	      </xsl:when>
	      <xsl:when test="Status='NOK' ">
			<td align="left" bgcolor="#FF0000">
				<xsl:value-of select="Status"/>
			</td>
	      </xsl:when>
	      <xsl:when test="(Status='NA ') or (Status='NA') or (Status='TBD') ">
	        <td align="left" bgcolor="#D3D3D3">
				<xsl:value-of select="Status"/>
	        </td>
	      </xsl:when>
		  <xsl:otherwise>
			<td align="left">
				<xsl:value-of select="Status"/>
			</td>
		  </xsl:otherwise>
		</xsl:choose>
		  
	      <xsl:if test="PopId!=' ' and PopId!='' ">
		<td align="left">
		  <xsl:value-of select="PopId" />
		</td>
	      </xsl:if>
	      <xsl:if test="PopTypeCode!=' ' and PopTypeCode!='' ">
		<td align="left">
		  <xsl:value-of select="PopTypeCode" />
		</td>
	      </xsl:if>
	      <td align="left">
		<xsl:value-of select="ParameterSet"/>
	      </td>
	      <td align="left">
		<xsl:value-of select="Creatietijd"/>
	      </td>
	      <td align="left">
		<xsl:value-of select="Tool"/>
	      </td>
	      <td align="left">
		<xsl:value-of select="Calibratietijd"/>
	      </td>
	      <td align="left">
		<xsl:value-of select="Operator"/>
	      </td>
	    </tr>
	  </table>
	  <br/>
	  <menu>
	    <li type="circle">
	      <u>Details
	      </u>
	      <table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
		<thead style="font:bold; background-color:#C0C0C0">
		  <tr>
		    <th>Detail
		    </th>
		    <th>Status
		    </th>
		    <th>Code
		    </th>
		    <th>Data
		    </th>
		    <th>Extra info
		    </th>
		  </tr>
		</thead>
		<xsl:for-each select="Onderdelen">
		  <tr>
		    <td align="left">
		      <xsl:value-of select="Onderdeel"/>
		    </td>
			<xsl:choose>
				<xsl:when test="(Status='OK ') or (Status='OK') or (Status='OK-NA')">
					<td align="left" bgcolor="#008000">
						<xsl:value-of select="Status"/>
					</td>
				</xsl:when>
				<xsl:when test="Status='NOK' ">
					<td align="left" bgcolor="#FF0000">
						<xsl:value-of select="Status"/>
					</td>
				</xsl:when>
				<xsl:when test="(Status='NA ') or (Status='NA') or (Status='TBD') ">
					<td align="left" bgcolor="#D3D3D3">
						<xsl:value-of select="Status"/>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td align="left">
						<xsl:value-of select="Status"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
	      	    
		    <td align="left">
		      <xsl:value-of select="Code"/>
		    </td>
		    <td align="left">
		      <xsl:value-of select="Data"/>
		    </td>
		    <td align="left">
		      <xsl:value-of select="ExtraInfo"/>
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
    <xsl:template match="Installations">
        <h2>
            <center>
                <i>Installation feedback
                </i>
            </center>
        </h2>
        <xsl:for-each select="InstallationData">
            <menu>
                <li type="disc">
                    <u>Installation
                    </u>
                    <table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
                        <thead style="font:bold; background-color:#C0C0C0">
                            <tr>
                                <th>Installation
                                </th>
                                <th>Status
                                </th>
                                <xsl:if test="PopId!=' ' and PopId!='' ">
                                    <th>POP id
                                    </th>
                                </xsl:if>
                                <xsl:if test="PopTypeCode!=' ' and PopTypeCode!='' ">
                                    <th>POPtype
                                    </th>
                                </xsl:if>
                                <th>Parameterset
                                </th>
                                <th>Registration time
                                </th>
                                <th>Tool
                                </th>
                                <th>Calibration time
                                </th>
                                <th>Operator
                                </th>
                            </tr>
                        </thead>
                        <tr>
                            <td align="left">
                                <xsl:value-of select="Installation"/>
                            </td>
                            <xsl:choose>
                                <xsl:when test="(Status='OK ') or (Status='OK') or (Status = 'OK-NA')">
                                    <td align="left" bgcolor="#008000">
                                        <xsl:value-of select="Status"/>
                                    </td>
                                </xsl:when>
                                <xsl:when test="Status='NOK' ">
                                    <td align="left" bgcolor="#FF0000">
                                        <xsl:value-of select="Status"/>
                                    </td>
                                </xsl:when>
                                <xsl:when test="(Status='NA ') or (Status='NA') or (Status='TBD') ">
                                    <td align="left" bgcolor="#D3D3D3">
                                        <xsl:value-of select="Status"/>
                                    </td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td align="left">
                                        <xsl:value-of select="Status"/>
                                    </td>
                                </xsl:otherwise>
                            </xsl:choose>

                            <xsl:if test="PopId!=' ' and PopId!='' ">
                                <td align="left">
                                    <xsl:value-of select="PopId"/>
                                </td>
                            </xsl:if>
                            <xsl:if test="PopTypeCode!=' ' and PopTypeCode!='' ">
                                <td align="left">
                                    <xsl:value-of select="PopTypeCode"/>
                                </td>
                            </xsl:if>
                            <td align="left">
                                <xsl:value-of select="ParameterSet"/>
                            </td>
                            <td align="left">
                                <xsl:value-of select="Creationtime"/>
                            </td>
                            <td align="left">
                                <xsl:value-of select="Tool"/>
                            </td>
                            <td align="left">
                                <xsl:value-of select="Calibrationtime"/>
                            </td>
                            <td align="left">
                                <xsl:value-of select="Operator"/>
                            </td>
                        </tr>
                    </table>
                    <br/>
                    <menu>
                        <li type="circle">
                            <u>Details
                            </u>
                            <table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
                                <thead style="font:bold; background-color:#C0C0C0">
                                    <tr>
                                        <th>Detail
                                        </th>
                                        <th>Status
                                        </th>
                                        <th>Code
                                        </th>
                                        <th>Data
                                        </th>
                                        <th>Extra info
                                        </th>
                                    </tr>
                                </thead>
                                <xsl:for-each select="Parts">
                                    <tr>
                                        <td align="left">
                                            <xsl:value-of select="Part"/>
                                        </td>
                                        <xsl:choose>
                                            <xsl:when test="(Status='OK ') or (Status='OK') or (Status='OK-NA')">
                                                <td align="left" bgcolor="#008000">
                                                    <xsl:value-of select="Status"/>
                                                </td>
                                            </xsl:when>
                                            <xsl:when test="Status='NOK' ">
                                                <td align="left" bgcolor="#FF0000">
                                                    <xsl:value-of select="Status"/>
                                                </td>
                                            </xsl:when>
                                            <xsl:when test="(Status='NA ') or (Status='NA') or (Status='TBD') ">
                                                <td align="left" bgcolor="#D3D3D3">
                                                    <xsl:value-of select="Status"/>
                                                </td>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <td align="left">
                                                    <xsl:value-of select="Status"/>
                                                </td>
                                            </xsl:otherwise>
                                        </xsl:choose>

                                        <td align="left">
                                            <xsl:value-of select="Code"/>
                                        </td>
                                        <td align="left">
                                            <xsl:value-of select="Data"/>
                                        </td>
                                        <td align="left">
                                            <xsl:value-of select="ExtraInfo"/>
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