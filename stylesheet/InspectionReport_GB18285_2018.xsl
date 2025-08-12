<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
    <title>
           Inspection Report
    </title>
	<style>
		body {
  			font-family:Arial;
			font-size:12pt;
			background-color:white;
			width:210mm;
			height:297mm;
			font-size: 12;
		}
		div.sectionhead {
			padding-left:10px;
			border-color: black;
			border-style: solid;
			font-weight:bold;
		}
		div.sectionhead2 {
			padding-left:10px;
			border-right-style:solid;
			border-bottom-style: solid;
			border-left-style: solid;
			font-weight:bold;
		}
		div.rl {
  			text-indent: 5;
			border-right-style:solid;
			border-left-style: solid;
		}
		div.row {
			display:table-row;
		}
 		div.cell {
			display:table-cell;
  			text-indent: 5;
		}
		div.cell-t {
			display:table-cell;
  			text-indent: 5;
			border-top-style:solid;
		}
		div.cell-tr {
			display:table-cell;
  			text-indent: 5;
			border-right-style:solid;
			border-top-style: solid;
		}
		div.cell-r {
			display:table-cell;
  			text-indent: 5;
			border-right-style:solid;
		}
		div.cell-rb {
			display:table-cell;
  			text-indent: 5;
			border-right-style:solid;
			border-bottom-style: solid;
		}
		div.cell-rbl {
			display:table-cell;
  			text-indent: 5;
			border-right-style:solid;
			border-bottom-style: solid;
			border-left-style: solid;
		}
		div.cell-rl {
			display:table-cell;
            text-indent: 5;
			border-right-style:solid;
			border-left-style: solid
		}
		div.cell-c-rl {
			display:table-cell;
  			text-align:center;
			border-right-style:solid;
			border-left-style: solid
		}
 		div.cell-c {
			display:table-cell;
  			text-align:center;
        }
		div.cell-c-r {
			display:table-cell;
  			text-align:center;
			border-right-style:solid;
		}
		div.cell-c-rbl {
			display:table-cell;
  			text-align:center;
			border-right-style:solid;
			border-bottom-style: solid;
			border-left-style: solid
		}
		div.cell-c-rb {
			display:table-cell;
  			text-align:center;
			border-right-style:solid;
			border-bottom-style: solid;
		}
		div.cell-c-tr {
			display:table-cell;
  			text-align:center;
			border-right-style:solid;
			border-top-style: solid;
		}
		div.cell-c-t {
			display:table-cell;
  			text-align:center;
			border-top-style: solid;
		}
	</style>
</head>

<body>

<div style="display:table-cell;font-size: 16">Report number: <span style="text-decoration: underline"><xsl:value-of select="inspection_report/ReportHeader/ReportNumber"/></span></div>
<div style="display:table-cell;font-size: 16;position: relative;left: 5cm">Inspection date <sup>1)</sup>: <span style="text-decoration: underline"><xsl:value-of select="inspection_report/ReportHeader/InspectionDate"/></span></div>
<br/>


<!-- GENERAL -->
<div class="sectionhead">G.1.1 Basic Information</div>
	<div class="row">
		<div class="cell-c-rbl" style="width:52mm">Vehicle model</div>
		<div class="cell-rb" style="width:53mm"> <xsl:value-of select="inspection_report/general/VehicleModel"/></div>
		<div class="cell-c-rb" style="width:52mm">Vehicle Identification Number (VIN)</div>
		<div class="cell-rb" style="width:53mm"> <xsl:value-of select="inspection_report/general/VIN"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl">Vehicle manufacturer</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/ManufName"/></div>
		<div class="cell-c-rb">Vehicle emission phase</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/VehicleEmissPhase"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl">Transmission type</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/TransmissionType"/></div>
		<div class="cell-c-rb">Catalytic converter model</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/CatalyticConModel"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl">Reference mass (kg)</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/ReferenceMass"/></div>
		<div class="cell-c-rb">Maximum design total mass (kg)</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/MaxMass"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl">Engine model</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/EngineModel"/></div>
		<div class="cell-c-rb">Engine Number</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/EngineNumber"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl">Engine manufacturer</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/EngineManuf"/></div>
		<div class="cell-c-rb">Engine displacement (L)</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/EngineDisplacement"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl">Number of cylinders</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/NOCylinders"/></div>
		<div class="cell-c-rb">Fuel supply method</div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/FuelSupply"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl">Motor model<sup>2)</sup></div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/MotorModel"/></div>
		<div class="cell-c-rb">Energy storage device model<sup>2)</sup></div>
		<div class="cell-rb"> <xsl:value-of select="inspection_report/general/EnergyStorageDevMod"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rl">Battery capacity<sup>2)</sup></div>
		<div class="cell-r"> <xsl:value-of select="inspection_report/general/BatteryCapacity"/></div>
		<div class="cell-c-r">OBD interface location</div>
		<div class="cell-r"> <xsl:value-of select="inspection_report/general/OBDInterfaceLocation"/></div>
	</div>

<!-- APPEARANCE -->
<div class="sectionhead">G.1.2 Appearance inspection</div>
	<div class="rl">The pollution control device installed on this vehicle is identical with vehicle environmental identification document.
	<br/><br/>
	<img src="../../clm/companySeal_2019.jpg" height="42" width="42"/>
	</div>

<!-- OBD -->
<div class="sectionhead">G.1.3 OBD inspection</div>
<div class="row">
<div class="cell-rbl" style="width:110mm">Is OBD communication normal</div>
<div class="cell-c-rb" style="width:100mm"> <input type="checkbox" checked="true"/><label>Yes </label> <input type="checkbox"/><label>No</label></div>
</div>

<div/>

<div class="row">
<div class="cell-c-rbl" style="width:40mm">CAL ID/CVN information</div>
<div class="cell-rb" style="width:170mm">
	<div class="row">
		<div class="cell-c-r" style="width:70mm">Engine control unit</div>
		<div class="cell-r" style="width:20mm">CAL ID</div>
		<div class="cell-r" style="width:30mm"> <xsl:value-of select="inspection_report/OBD/EControlUnit/ECM-Service0904"/></div>
		<div class="cell-r" style="width:20mm">CVN</div>
		<div class="cell" style="width:30mm"> <xsl:value-of select="inspection_report/OBD/EControlUnit/ECM-Service0906"/></div>
	</div>
	<div class="row">
		<div class="cell-c-tr">Post-processing control unit (if applicable)</div>
		<div class="cell-tr">CAL ID</div>
		<div class="cell-tr"> <xsl:value-of select="inspection_report/OBD/PControlUnit/P-Service0904"/></div>
		<div class="cell-tr">CVN</div>
		<div class="cell-t"> <xsl:value-of select="inspection_report/OBD/PControlUnit/P-Service0906"/></div>
	</div>
	<xsl:for-each select="inspection_report/OBD/OControlUnit">
		<div class="row">
		<div class="cell-c-tr">Other control units (if applicable)</div>
		<div class="cell-tr">CAL ID</div>
		<div class="cell-tr"> <xsl:value-of select="Other-Service0904"/></div>
		<div class="cell-tr">CVN</div>
		<div class="cell-t"> <xsl:value-of select="Other-Service0906"/></div>
		</div>
	</xsl:for-each>
</div>
</div>

<div/>

<div class="row">
	<div class="cell-rl" style="width:110mm">OBD inspection result</div>
	<div class="cell-c-r" style="width:100mm">
		<div class="row">
			<div class="cell-c-r" style="width:50mm"><input type="checkbox" checked="true"/><label>Eligible </label> <input type="checkbox"/><label>Ineligible</label></div>
			<div class="cell" style="width:50mm; text-align: left">Inspector: ATACQ (Production Control)</div>
	</div>
	</div>
</div>

<!-- EMISSION -->
<div class="sectionhead">G.1.4 Pollutant exhaust test</div>
<div class="sectionhead2">Environmental parameter</div>

	<div class="row">
		<div class="cell-c-rl" style="width:65mm">Environmental temperature (<sup>o</sup>C)</div>
		<div class="cell-r" style="width:25mm"><xsl:value-of select="inspection_report/emission/ET"/></div>
		<div class="cell-c-r" style="width:35mm">Atmospheric pressure (kPa)</div>
		<div class="cell-r" style="width:25mm"><xsl:value-of select="inspection_report/emission/AP"/></div>
		<div class="cell-c-r" style="width:35mm">Relative humidity (%)</div>
		<div class="cell-r" style="width:25mm"> <xsl:value-of select="inspection_report/emission/RH"/></div>
	</div>

<div class="sectionhead">/Analyzer/dynometer parameters</div>

	<div class="row">
		<div class="cell-c-rbl" style="width:65mm">Analyzer manufacturer</div>
		<div class="cell-rb" style="width:25mm"><xsl:value-of select="inspection_report/emission/AnalyManuf"/></div>
		<div class="cell-c-rb" style="width:35mm">Analyzer name</div>
		<div class="cell-rb" style="width:25mm"><xsl:value-of select="inspection_report/emission/AnalyName"/></div>
		<div class="cell-c-rb" style="width:35mm">Verification date of analyzer</div>
		<div class="cell-rb" style="width:25mm"> <xsl:value-of select="inspection_report/emission/AnalyDate"/></div>
	</div>
	<div class="row">
		<div class="cell-c-rbl" style="width:65mm">Chassis dynamometer manufacturer</div>
		<div class="cell-rb" style="width:25mm"><xsl:value-of select="inspection_report/emission/DynoManuf"/></div>
		<div class="cell-c-rb" style="width:35mm">Chassis dynanometer model</div>
		<div class="cell-rb" style="width:25mm"><xsl:value-of select="inspection_report/emission/DynoModel"/></div>
		<div class="cell-rb" style="width:35mm"/>
		<div class="cell-rb" style="width:25mm"/>
	</div>

<div/>

<div class="row">
<div class="cell-rbl" style="width:40mm"><input type="checkbox"/><label>Transient loaded mode </label> </div>
<div class="cell-rb" style="width:170mm">
	<div class="row">
		<div class="cell-c-r" style="width:40mm"/>
		<div class="cell-c-r" style="width:70mm">CO (g/km)</div>
		<div class="cell-c" style="width:70mm"> HC+NOx (g/km)</div>
	</div>
	<div class="row">
		<div class="cell-c-tr" style="width:40mm">Measured value</div>
		<div class="cell-c-tr" style="width:70mm"></div>
		<div class="cell-c-t" style="width:70mm"></div>
	</div>
	<div class="row">
		<div class="cell-c-tr">Enterprise limit</div>
		<div class="cell-c-tr"></div>
		<div class="cell-c-t"></div>
	</div>
</div>
</div>

<div class="row">
<div class="cell-rbl" style="width:40mm">
	<input type="checkbox">
		<xsl:if test="inspection_report/emission/@epass='1'">
			<xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	</input>
	<label>Short transient loaded mode </label> 
</div>
<div class="cell-rb" style="width:170mm">
	<div class="row">
		<div class="cell-c-r" style="width:40mm"/>
		<div class="cell-c-r" style="width:46mm">HC (g/km)</div>
		<div class="cell-c-r" style="width:47mm"> CO (g/km)</div>
		<div class="cell-c" style="width:46mm"> NOx (g/km)</div>
	</div>
	<div class="row">
		<div class="cell-c-tr" style="width:40mm">Measured value</div>
		<div class="cell-c-tr" style="width:46mm"><xsl:value-of select="inspection_report/emission/vrhc"/></div>
		<div class="cell-c-tr" style="width:47mm"> <xsl:value-of select="inspection_report/emission/vrco"/></div>
		<div class="cell-c-t" style="width:46mm"> <xsl:value-of select="inspection_report/emission/vrnox"/></div>
	</div>
	<div class="row">
		<div class="cell-c-tr" style="width:40mm">Enterprise limit</div>
		<div class="cell-c-tr" style="width:46mm"><xsl:value-of select="inspection_report/emission/vehc"/></div>
		<div class="cell-c-tr" style="width:47mm"> <xsl:value-of select="inspection_report/emission/veco"/></div>
		<div class="cell-c-t" style="width:46mm"> <xsl:value-of select="inspection_report/emission/venox"/></div>
	</div>
</div>
</div>

<div class="row">
<div class="cell-rbl" style="width:40mm"><input type="checkbox"/><label>Steady state loaded mode </label> </div>
<div class="cell-rb" style="width:170mm">
	<div class="row">
		<div class="cell-c-r" style="width:40mm"/>
		<div class="cell-c-r" style="width:46mm">HC (10<sup>-6</sup>)</div>
		<div class="cell-c-r" style="width:47mm"> CO (%)</div>
		<div class="cell-c" style="width:46mm"> NOx (10<sup>-6</sup>)</div>
	</div>
	<div class="row">
		<div class="cell-c-tr" style="width:40mm">Measured value</div>
		<div class="cell-c-tr" style="width:46mm"></div>
		<div class="cell-c-tr" style="width:47mm"></div>
		<div class="cell-c-t" style="width:46mm"></div>
	</div>
	<div class="row">
		<div class="cell-c-tr" style="width:40mm">Enterprise limit</div> <!-- NA -->
		<div class="cell-c-tr" style="width:46mm"></div>
		<div class="cell-c-tr" style="width:47mm"></div>
		<div class="cell-c-t" style="width:46mm"></div>
	</div>
</div>
</div>

<div class="row">
<div class="cell-rbl" style="width:40mm"><input type="checkbox"/><label>Two-speed idle conditions </label> </div>
<div class="cell-rb" style="width:170mm">
	<div class="row">
		<div class="cell-c-r" style="width:40mm"/>
		<div class="cell-c-r" style="width:47mm">
			Exess air coefficient
			<div class="row">
				<div class="cell-c" style="width:46mm">λ</div>
			</div>
		</div>
		<div class="cell-c-r" style="width:47mm">
			Low idel
			<div class="row">
				<div class="cell-c-tr" style="width:23mm">CO (%)</div>
				<div class="cell-t" style="width:24mm">HC (10<sup>-6</sup>)</div>
			</div>
		</div>
		<div style="display:table-cell;width:46mm;text-align:center">
			High idel
			<div class="row">
				<div class="cell-c-tr" style="width:23mm">CO (%)</div>
				<div class="cell-t" style="width:23mm">HC (10<sup>-6</sup>)</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="cell-c-tr" style="width:40mm">Measured value</div>
		<div class="cell-c-tr" style="width:46mm"></div>
		<div class="cell-c-tr" style="width:47mm"></div>
		<div class="cell-c-t" style="width:46mm"></div>
	</div>
	<div class="row">
		<div class="cell-c-tr">Enterprise limit</div>
		<div class="cell-c-tr"></div>
		<div class="cell-c-tr"></div>
		<div class="cell-c-t"></div>
	</div>
</div>
</div>
<div/>
<div class="row">
	<div class="cell-rbl" style="width:79mm">Pollutant discharge result</div>
	<div class="cell-rb" style="width:131mm">
		<div class="row">
			<div class="cell-c-r" style="width:65.5mm">
				<input type="checkbox"> 
					<xsl:if test="inspection_report/emission/@epass='1'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
				<label>Eligible </label> 
				<input type="checkbox"> 
					<!--xsl:if test="inspection_report/emission/@epass='2'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if-->
				</input>
				<label>Ineligible</label>
			</div>
			<div class="cell" style="width:65.5mm">Inspector: ATACQ (Production Control)</div>
	</div>
	</div>
</div>
<div/>
<div class="cell-rbl" style="width:210mm;padding-left:5">
	<span style="font-weight:bold">Note:</span><br/>
	1) 8-bit, year(4-bit) + month (2-bit) + date (2-bit)<br/>
	2) Only for hybrid vehicles
</div>

</body>
</html>
</xsl:template>
</xsl:stylesheet>

