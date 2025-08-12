<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes" version="2.0">
	<xsl:template match="Wagen">
		<html>
			<head>
				<title>Car</title>
			</head>
			<body>
				<h1>Car</h1>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Properties | Eigenschappen">
		<h2>
			<u>
Type:
<em>
					<xsl:value-of select="MainType | Hoofdtype"/>
				</em>
Chassis:
<em>
					<xsl:value-of select="Chassis"/>
				</em>
			</u>
		</h2>
		<br/>
		<b>Fyonnumber: </b>
		<xsl:value-of select="Fyonnr"/>
		<br/>
		<b>Mixnumber: </b>
		<xsl:value-of select="Mixnr"/>
		<br/>
		<b>Production line: </b>
		<xsl:value-of select="ProductionLine | Productielijn"/>
		<br/>
		<b>Bodynumber: </b>
		<xsl:value-of select="Bodynr"/>
		<br/>
		<b>Variant: </b>
		<xsl:value-of select="Variant"/>
		<br/>
		<b>Vinnumber: </b>
		<xsl:value-of select="VinNumber | Vinnummer"/>
		<br/>
		<b>Bodytype: </b>
		<xsl:value-of select="Bodytype"/>
		<br/>
		<b>Model year: </b>
		<xsl:value-of select="ModelYear | Modeljaar"/>
		<br/>
		<b>Planned assembly week: </b>
		<xsl:value-of select="PlannedAssemblyWeek"/>
		<br/>
		<b>Date factory complete: </b>
		<xsl:value-of select="DateFC | DatumFC"/>
		<br/>
		<b>MFK: </b>
		<xsl:value-of select="MFK"/>
		<br/>
		<b>Market: </b>
		<xsl:value-of select="Market | Markt"/>
		<br/>
		<b>Order manager distr. point: </b>
		<xsl:value-of select="Romdipt"/>
		<br/>
		<b>District: </b>
		<xsl:value-of select="District"/>
		<br/>
		<b>Dealer Id: </b>
		<xsl:value-of select="Dealer"/>
		<br/>
		<b>Final destination: </b>
		<xsl:value-of select="FinalDestination"/>
		<br/>
		<b>Primer: </b>
		<xsl:value-of select="Primer | Surfacer"/>
		<br/>
		<b>Color: </b>
		<xsl:value-of select="Color | Kleur"/>
		<br/>
		<b>Paint supplier: </b>
		<xsl:value-of select="PaintSupplier | Verflev"/>
		<br/>
		<b>Upholstery: </b>
		<xsl:value-of select="Upholstery | Bekleding"/>
		<br/>
		<b>Registration date: </b>
		<xsl:value-of select="RegistrationDate | Registratiedatum"/>
		<br/>
		<b>Tryout: </b>
		<xsl:value-of select="Tryout"/>
		<br/>
		<b>Tryout GC: </b>
		<xsl:value-of select="TryoutCShop | TryoutGC"/>
		<br/>
		<b>Attachments: </b>
		<xsl:value-of select="Attachments | Bijlagen"/>
		<br/>
		<b>Tag Id: </b>
		<xsl:value-of select="TagID"/>
		<br/>
		<br/>
		<br/>
	</xsl:template>
	<xsl:template match="Items">
		<h2>
			<u>ATACQ-items</u>
		</h2>
		<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
			<thead style="font:bold; background-color:#C0C0C0">
				<tr>
					<th>Code</th>
					<th>ATACQ-item</th>
					<th>TracyAction</th>
					<th>TracyMode</th>
					<th>Description</th>
					<th>Linking date</th>
					<th>Linked by</th>
					<th>Closing date</th>
					<th>Closed by</th>
					<th>Handling place</th>
					<th>Causing team</th>
					<th>ATACQ-item family</th>
					<th>ATACQ workstation</th>
					<th>Refined ATACQ-item</th>
					<th>Workstation</th>
					<th>Causing person</th>
					<th>Day</th>
					<th>Shift</th>
					<th>Attachments</th>
					<th>PopTypeCode</th>
					<th>PopId</th>
				</tr>
			</thead>
			<xsl:for-each select="AtacqItem">
				<tr>
					<td align="center">
						<xsl:value-of select="Code"/>
					</td>
					<td align="left">
						<xsl:value-of select="AtacqItem"/>
					</td>
					<td align="left">
						<xsl:value-of select="TracyAction | TracyAktie"/>
					</td>
					<td align="left">
						<xsl:value-of select="TracyMode"/>
					</td>
					<td align="left">
						<xsl:value-of select="Description | Omschrijving"/>
					</td>
					<td align="center">
						<xsl:value-of select="LinkingDate | MeldDatum"/>
					</td>
					<td align="center">
						<xsl:value-of select="LinkedBy | Melder"/>
					</td>
					<td align="center">
						<xsl:value-of select="ClosingDate | AfmeldDatum"/>
					</td>
					<td align="center">
						<xsl:value-of select="ClosedBy | Afmelder"/>
					</td>
					<td align="center">
						<xsl:value-of select="HandlingPlace | Uitvoeringsplaats"/>
					</td>
					<td align="center">
						<xsl:value-of select="CausingTeam | Team"/>
					</td>
					<td align="left">
						<xsl:value-of select="AtacqItemFamily | AtacqItemFamilie"/>
					</td>
					<td align="left">
						<xsl:value-of select="AtacqWorkStation | AtacqWerkpost"/>
					</td>
					<td align="left">
						<xsl:value-of select="RefinedAtacqItem | VerfijndAtacqItem"/>
					</td>
					<td align="center">
						<xsl:value-of select="WorkStation | Werkpost"/>
					</td>
					<td align="center">
						<xsl:value-of select="CausingPerson | Veroorzaker"/>
					</td>
					<td align="center">
						<xsl:value-of select="Day | Dag"/>
					</td>
					<td align="center">
						<xsl:value-of select="Shift | Ploeg"/>
					</td>
					<td align="center">
						<xsl:value-of select="Attachments | Bijlagen"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopTypeCode"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopId"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<br/>
	</xsl:template>
	<xsl:template match="RegistrationPoints | Incidenten">
		<h2>
			<u>Registration points</u>
		</h2>
		<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
			<thead style="font:bold; background-color:#C0C0C0">
				<tr>
					<th>Registration point</th>
					<th>Description</th>
					<th>Registration date</th>
					<th>PopTypeCode</th>
					<th>PopId</th>
				</tr>
			</thead>
			<xsl:for-each select="RegistrationPoint | Registratiepunt">
				<tr>
					<td align="center">
						<xsl:value-of select="Incident"/>
					</td>
					<td align="left">
						<xsl:value-of select="Description | Omschrijving"/>
					</td>
					<td align="center">
						<xsl:value-of select="Date | Datum"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopTypeCode"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopId"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<br/>
	</xsl:template>
	<xsl:template match="QWItems">
		<h2>
			<u>QWItems</u>
		</h2>
		<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
			<thead style="font:bold; background-color:#C0C0C0">
				<tr>
					<th>QWItem</th>
					<th>Description</th>
					<th>Registration date</th>
					<th>Validity code</th>
					<th>Part number</th>
					<th>PopTypeCode</th>
					<th>PopId</th>
					<th>Last scanned on</th>
				</tr>
			</thead>
			<xsl:for-each select="QWItem">
				<tr>
					<td align="center">
						<xsl:value-of select="QWItem"/>
					</td>
					<td align="left">
						<xsl:value-of select="Description | Omschrijving"/>
					</td>
					<td align="center">
						<xsl:value-of select="RegistrationDate | Registratiedatum"/>
					</td>
					<td align="left">
						<xsl:value-of select="ValidityCode"/>
					</td>
					<td align="left">
						<xsl:value-of select="PartNumber | Stuknummer"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopTypeCode"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopId"/>
					</td>
					<td align="center">
						<xsl:value-of select="LastScannedOn"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<br/>
	</xsl:template>
	<xsl:template match="RemarksABShop | OpmerkingenGAGB">
		<h2>
			<u>Remarks A/B-shop</u>
		</h2>
		<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
			<thead style="font:bold; background-color:#C0C0C0">
				<tr>
					<th>Linking time</th>
					<th>Closing time</th>
					<th>Factory</th>
					<th>Repair code</th>
					<th>Repair code description</th>
					<th>Fault area</th>
					<th>Error description</th>
					<th>ATACQ-item</th>
					<th>Inspector</th>
					<th>Inspector description</th>
					<th>Repair person ID</th>
					<th>Repair person name</th>
				</tr>
			</thead>
			<xsl:for-each select="Remark | Opmerking">
				<tr>
					<td align="center">
						<xsl:value-of select="LinkingTime | Meldtijd"/>
					</td>
					<td align="center">
						<xsl:value-of select="ClosingTime | Afmeldtijd"/>
					</td>
					<td align="center">
						<xsl:value-of select="Factory | Fabriek"/>
					</td>
					<td align="center">
						<xsl:value-of select="RepairCode | Herstelcode"/>
					</td>
					<td align="left">
						<xsl:value-of select="RepairCodeDescription | Hersteloms"/>
					</td>
					<td align="center">
						<xsl:value-of select="FaultArea | Foutplaats"/>
					</td>
					<td align="left">
						<xsl:value-of select="ErrorDescription | Foutoms"/>
					</td>
					<td align="left">
						<xsl:value-of select="AtacqItem | Foutcode"/>
					</td>
					<td align="center">
						<xsl:value-of select="Inspector"/>
					</td>
					<td align="left">
						<xsl:value-of select="InspectorDescription | InspectorOms"/>
					</td>
					<td align="center">
						<xsl:value-of select="RepairPersonId | Hersteller"/>
					</td>
					<td align="left">
						<xsl:value-of select="RepairPersonName | HerstellerOms"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<br/>
	</xsl:template>
	<xsl:template match="RotationHistory | RotatieHistoriek">
		<h2>
			<u>Rotation history</u>
		</h2>
		<table style="font:8pt Arial" border="1" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
			<thead style="font:bold; background-color:#C0C0C0">
				<tr>
					<th>Team</th>
					<th>Workstation</th>
					<th>Shift</th>
					<th>From Mix Nr</th>
					<th>To Mix Nr</th>
					<th>PopTypeCode</th>
					<th>From Pop Id</th>
					<th>To Pop Id</th>
					<th>User Id</th>
					<th>Operator name</th>
					<th>Start date</th>
					<th>Number of vehicles</th>
					<th>Number of errors</th>
					<th>PopId</th>
				</tr>
			</thead>
			<xsl:for-each select="RotationCard | RotatieKaart">
				<tr>
					<td align="left">
						<xsl:value-of select="Team"/>
					</td>
					<td align="center">
						<xsl:value-of select="WorkStation | Werkpost"/>
					</td>
					<td align="center">
						<xsl:value-of select="Shift | Ploeg"/>
					</td>
					<td align="center">
						<xsl:value-of select="FromMixNr | MixnummerVan"/>
					</td>
					<td align="center">
						<xsl:value-of select="ToMixNr | MixnummerTot"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopTypeCode"/>
					</td>
					<td align="center">
						<xsl:value-of select="FromPopId | PopIdVan"/>
					</td>
					<td align="center">
						<xsl:value-of select="ToPopId | PopIdTot"/>
					</td>
					<td align="center">
						<xsl:value-of select="UserId | PersoneelsNummer"/>
					</td>
					<td align="left">
						<xsl:value-of select="NameOperator | NaamOperator"/>
					</td>
					<td align="center">
						<xsl:value-of select="StartDate | TijdstipIngave"/>
					</td>
					<td align="center">
						<xsl:value-of select="NumberOfVehicles | AantalWagens"/>
					</td>
					<td align="center">
						<xsl:value-of select="NumberOfErrors | AantalFouten"/>
					</td>
					<td align="center">
						<xsl:value-of select="PopId"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<br/>
	</xsl:template>
</xsl:stylesheet>
