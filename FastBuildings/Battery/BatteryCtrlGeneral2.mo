within FastBuildings.Battery;
model BatteryCtrlGeneral2
  /*
Surplus of PV-production to batteries, and discharging if the PV-production is not enough
 
Remark: should be working; only 1 phase!*/
  extends Modelica.Blocks.Interfaces.BlockIcon;

  // Total battery capacity in [kW.h]
  parameter Modelica.SIunits.Efficiency eta_out=1;
  parameter Modelica.SIunits.Efficiency eta_in=1;
  parameter Modelica.SIunits.Efficiency eta_d=1;
  parameter Modelica.SIunits.Efficiency eta_c=1;
  parameter Real e_c(
    final quantity="Frequency",
    final unit="1/h") = 1;
  parameter Real e_d(
    final quantity="Frequency",
    final unit="1/h") = 1;

  // Physical constraints
  parameter Modelica.SIunits.Efficiency DoD_max=0.8 "Depth of Discharge %";
  parameter Modelica.SIunits.Energy E_max=1 "Max. Energy [J]";
  parameter Modelica.SIunits.Power PMax=4600*numPha
    "Max. charging power [W], limited by grid connection";
  parameter Modelica.SIunits.Power PCharge=min(PMax, (E_max/3600*e_c))
    "Max. charging power [W], limited by battery type";
  parameter Modelica.SIunits.Power PDischarge=min(PMax, (E_max/3600*e_d))
    "Max. discharging power [W], limited by battery type";

  // Inputs (to controller) and outputs (to battery)
  Modelica.Blocks.Interfaces.RealInput P(final quantity="Power", final unit="W") annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealInput SoC
    "Negative for discharging (sign convention seen from battery model)" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0})));
  Modelica.Blocks.Interfaces.RealOutput PBat_charge(final quantity="Power", final unit="W")
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,50})));
  Modelica.Blocks.Interfaces.RealOutput PBat_discharge(final quantity="Power", final unit="W")
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-50})));
  Modelica.Blocks.Interfaces.RealOutput P_net(final quantity="Power", final unit="W") annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-120,50})));

  parameter Integer numPha=1
    "1 or 3, just indicates if it is a single or 3 phase battery system";

equation
  // Limiting powers when battery almost full/empty
  // Discharging batteries (P negative)
  if noEvent(P <= 0) then
    PBat_discharge = if noEvent((((1 - DoD_max) - SoC)*E_max) > (P/(eta_out*eta_d))) then ((SoC - (1 -
      DoD_max))*E_max) else min(abs(P), PDischarge);
    PBat_charge = 0;
    // Charging batteries
  else
    //if noEvent(P > 0) then
    PBat_charge = if noEvent(((1 - SoC)*E_max) < P*eta_in*eta_c) then ((1 - SoC)*E_max) else min(P,
      PCharge);
    PBat_discharge = 0;
  end if;

  P_net = -P + PBat_discharge - PBat_charge annotation (Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-100,-100},{100,100}}), graphics));

  annotation (Documentation(info="<html>
<p>Battery controller which ensures</p>
</html>"));
end BatteryCtrlGeneral2;
