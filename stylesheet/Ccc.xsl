<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="CCC">
		<html>
			<head>
				<title>Bolt data</title>
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
                            <u>Bolt data
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
		<xsl:value-of select="MixNumber" />
		<br/> <b>Fyon: </b>
        <xsl:value-of select="Fyonnummer" />
		<xsl:value-of select="FyonNumber" />
		<br/> <b>Body: </b>
        <xsl:value-of select="Bodynummer" />
		<xsl:value-of select="BodyNumber" />
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

	<xsl:template match="Nutrunner">
		<h2>
			<center>
				<i>Nutrunner machine data</i>
			</center>
		</h2>
		<xsl:for-each select="InterfaceData">
			<menu>
				<li type="disc">
					<u>Interface</u>
					<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
						<thead style="font:bold; background-color:#C0C0C0">
							<tr>
								<th>Interface</th>
								<th>Status</th>
								<th>Station</th>
								<th>Status</th>
								<th>Line</th>
							</tr>
						</thead>
						<tr>
							<td align="center">
								<xsl:value-of select="Interface"/>
							</td>
							<xsl:if test="(InterfaceStatus='OK ') or (InterfaceStatus='OK') ">
								<td align="left" bgcolor="#008000">
									<xsl:value-of select="InterfaceStatus"/>
								</td>
							</xsl:if>
							<xsl:if test="InterfaceStatus='NOK' ">
								<td align="left" bgcolor="#FF0000">
									<xsl:value-of select="InterfaceStatus"/>
								</td>
							</xsl:if>
							<td align="left">
								<xsl:value-of select="Station"/>
							</td>
							<xsl:if test="(StationStatus='OK ') or (StationStatus='OK') ">
								<td align="left" bgcolor="#008000">
									<xsl:value-of select="StationStatus"/>
								</td>
							</xsl:if>
							<xsl:if test="StationStatus='NOK' ">
								<td align="left" bgcolor="#FF0000">
									<xsl:value-of select="StationStatus"/>
								</td>
							</xsl:if>
							<td align="left">
								<xsl:value-of select="Line"/>
								<xsl:value-of select="Lijn"/>
							</td>
						</tr>
					</table>
					<br/>
					<menu>
						<li type="circle">
							<u>Componenten</u>
							<xsl:for-each select="ComponentData">
								<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1"
									   bgcolor="#FFFFFF">
									<thead style="font:bold; background-color:#C0C0C0">
										<tr>
											<th>Component</th>
											<th>Description</th>
											<th>Status</th>
											<th>Controller</th>
										</tr>
									</thead>
									<tr>
										<td align="center">
											<xsl:value-of select="Component"/>
										</td>
										<td align="left">
											<xsl:value-of select="Description"/>
											<xsl:value-of select="Omschrijving"/>
										</td>
										<xsl:if test="(Status='OK ') or (Status='OK')">
											<td align="left" bgcolor="#008000">
												<xsl:value-of select="Status"/>
											</td>
										</xsl:if>
										<xsl:if test="Status='NOK' ">
											<td align="left" bgcolor="#FF0000">
												<xsl:value-of select="Status"/>
											</td>
										</xsl:if>
										<td align="left">
											<xsl:value-of select="Controller"/>
										</td>
									</tr>
								</table>
								<br/>
								<menu>
									<li type="square">
										<u>Parametersettings</u>
										<br/>
										<xsl:choose>
											<xsl:when test="Remark='NO PARAMETERSET FOUND'">
												<b>
													<xsl:value-of select="Remark"/>
													<br/>
												</b>
											</xsl:when>
											<xsl:otherwise>
												<b>Parameterset cyclus <xsl:value-of select="Cyclus"/>(<xsl:value-of
														select="CyclusDate"/>)
												</b>
												<br/>
												<table style="font:8pt Verdana" cellspacing="2" cellpadding="2"
													   width="75%">
													<tr>
														<td>Start Speed</td>
														<td>
															<b>
																<xsl:value-of select="StartSpeed"/>
															</b>
														</td>
														<td>Enter Angle (A2)</td>
														<td>
															<b>
																<xsl:value-of select="EnterAngleA2"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Start Time High Speed</td>
														<td>
															<b>
																<xsl:value-of select="StartTimeHighSpeed"/>
															</b>
														</td>
														<td>Min Tapping Torque (T2min)</td>
														<td>
															<b>
																<xsl:value-of select="MinTappingTorque"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>High Speed</td>
														<td>
															<b>
																<xsl:value-of select="HighSpeed"/>
															</b>
														</td>
														<td>Max Tapping Torque (T2max)</td>
														<td>
															<b>
																<xsl:value-of select="MaxTappingTorqueT2Max"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Init End Speed Torque</td>
														<td>
															<b>
																<xsl:value-of select="InitEndSpeedTorque"/>
															</b>
														</td>
														<td>Target Final Torque (T4)</td>
														<td>
															<b>
																<xsl:value-of select="TargetFinalTorque"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>End Speed</td>
														<td>
															<b>
																<xsl:value-of select="EndSpeed"/>
															</b>
														</td>
														<td>Min Final Torque (T4min)</td>
														<td>
															<b>
																<xsl:value-of select="MinFinalTorqueT4Min"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Start Torque (T1)</td>
														<td>
															<b>
																<xsl:value-of select="StartTorqueT1"/>
															</b>
														</td>
														<td>Max Final Torque (T4max)</td>
														<td>
															<b>
																<xsl:value-of select="MaxFinalTorqueT4Max"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>End Torque (T2)</td>
														<td>
															<b>
																<xsl:value-of select="EndTorqueT2"/>
															</b>
														</td>
														<td>Init Final Angle Torque (T3)</td>
														<td>
															<b>
																<xsl:value-of select="InitFinalAngleTorqueT3"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Min Angle (A2min)</td>
														<td>
															<b>
																<xsl:value-of select="MinAngleA2Min"/>
															</b>
														</td>
														<td>Target Final Angle (A4)</td>
														<td>
															<b>
																<xsl:value-of select="TargetFinalAngleA4"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Max Angle (A2max)</td>
														<td>
															<b>
																<xsl:value-of select="MaxAngleA2Max"/>
															</b>
														</td>
														<td>Min Final Angle (A4min)</td>
														<td>
															<b>
																<xsl:value-of select="MinFinalAngleA4Min"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Start Torque (T1)</td>
														<td>
															<b>
																<xsl:value-of select="EnterTorque"/>
															</b>
														</td>
														<td>Max Final Angle (A4max)</td>
														<td>
															<b>
																<xsl:value-of select="MaxFinalAngleA4Max"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Vanaf Mixnr</td>
														<td>
															<b>
																<xsl:value-of select="MixNumber"/>
															</b>
														</td>
														<td>Bolt</td>
														<td>
															<b>
																<xsl:value-of select="Bolt"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Introductiondate</td>
														<td>
															<b>
																<xsl:value-of select="IntroductionDate"/>
															</b>
														</td>
													</tr>
													<tr>
														<td>Planned from, till</td>
														<td>
															<b>
																<xsl:value-of select="Planned"/>
															</b>
														</td>
													</tr>
												</table>
											</xsl:otherwise>
										</xsl:choose>
										<br/>
										<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1"
											   bgcolor="#FFFFFF">
											<thead style="font:bold; background-color:#FFFFFF">
												<tr>
													<th/>
													<th/>
													<th/>
													<th colspan="3" style="background-color:#C0C0C0">Torque</th>
													<th colspan="3" style="background-color:#C0C0C0">Angle A2</th>
													<th colspan="3" style="background-color:#C0C0C0">Angle A4</th>
													<th/>
												</tr>
											</thead>
											<thead style="font:bold; background-color:#C0C0C0">
												<tr>
													<th>Bolt</th>
													<th>Stat.</th>
													<th>Toolid</th>
													<th>Tor.</th>
													<th>Min.</th>
													<th>Max.</th>
													<th>Ang. A2</th>
													<th>Min. A2</th>
													<th>Max. A2</th>
													<th>Ang. A4</th>
													<th>Min. A4</th>
													<th>Max. A4</th>
													<th>ToolCaldate</th>
												</tr>
											</thead>
											<xsl:for-each select="BoltData">
												<tr>
													<td align="center">
														<xsl:value-of select="Bolt"/>
													</td>
													<xsl:if test="(Status='OK ') or (Status='OK')">
														<td align="left" bgcolor="#008000">
															<xsl:value-of select="Status"/>
														</td>
													</xsl:if>
													<xsl:if test="Status='NOK' ">
														<td align="left" bgcolor="#FF0000">
															<xsl:value-of select="Status"/>
														</td>
													</xsl:if>
													<td align="center">
														<xsl:value-of select="Tool"/>
													</td>
													<td align="left">
														<xsl:value-of select="TorqueDesc"/>
													</td>
													<td align="left">
														<xsl:value-of select="TorqueMin"/>
													</td>
													<td align="left">
														<xsl:value-of select="TorqueMax"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleDesc"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMin"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMax"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleDescA4"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMinA4"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMaxA4"/>
													</td>
													<td align="center">
														<xsl:value-of select="Date"/>
													</td>
												</tr>
											</xsl:for-each>
											<xsl:for-each select="BoutData">
												<tr>
													<td align="center">
														<xsl:value-of select="Bout"/>
													</td>
													<xsl:if test="Status='OK ' ">
														<td align="left" bgcolor="#008000">
															<xsl:value-of select="Status"/>
														</td>
													</xsl:if>
													<xsl:if test="Status='NOK' ">
														<td align="left" bgcolor="#FF0000">
															<xsl:value-of select="Status"/>
														</td>
													</xsl:if>
													<td align="center">
														<xsl:value-of select="Tool"/>
													</td>
													<td align="left">
														<xsl:value-of select="TorqueDesc"/>
													</td>
													<td align="left">
														<xsl:value-of select="TorqueMin"/>
													</td>
													<td align="left">
														<xsl:value-of select="TorqueMax"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleDesc"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMin"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMax"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleDescA4"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMinA4"/>
													</td>
													<td align="left">
														<xsl:value-of select="AngleMaxA4"/>
													</td>
													<td align="center">
														<xsl:value-of select="Date"/>
													</td>
												</tr>
											</xsl:for-each>
										</table>
										<hr align="left" width="70%"/>
										<br/>
									</li>
								</menu>
							</xsl:for-each>
						</li>
					</menu>
				</li>
			</menu>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

