within AixLib.Building.HighOrder.Examples;


model Appartment_VoWo "Simulation of 1 apartment "
  import AixLib;
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the system"                                                                             annotation(Dialog(group = "Medium"), choicesAllMatching = true);
  AixLib.Building.HighOrder.House.MFD.BuildingAndEnergySystem.OneAppartment_Radiators
                                                                                      VoWoWSchV1984(redeclare
      package Medium =                                                                                                     Medium, fixedHeatFlow3(T_ref = 288.15), fixedHeatFlow5(T_ref = 283.15), fixedHeatFlow16(T_ref = 288.15)) annotation(Placement(transformation(extent = {{-42, -4}, {36, 46}})));
  AixLib.HVAC.HeatGeneration.Boiler boilerTable(boilerEfficiencyB = AixLib.DataBase.Boiler.BoilerConst()) annotation(Placement(transformation(extent = {{-44, -86}, {-64, -66}}, rotation = 0)));
  AixLib.HVAC.Pumps.Pump Pumpe annotation(Placement(transformation(extent = {{4, -82}, {-16, -62}})));
  AixLib.HVAC.Pipes.StaticPipe pipe annotation(Placement(transformation(extent = {{-30, -48}, {-18, -36}})));
  AixLib.HVAC.Pipes.StaticPipe pipe2 annotation(Placement(transformation(extent = {{26, -50}, {38, -38}})));
  AixLib.Building.Components.Weather.Weather combinedWeather(Latitude = 49.5, Longitude = 8.5, Wind_dir = false, Wind_speed = true, Air_temp = true, SOD = AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_NE_SE_SW_NW_Hor(), fileName = "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt") annotation(Placement(transformation(extent = {{-82, 74}, {-50, 96}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Source_TsetChildren(k = 273.15 + 22) annotation(Placement(transformation(extent = {{-100, 8}, {-86, 22}})));
  Modelica.Blocks.Sources.Constant Source_TsetLivingroom(k = 273.15 + 20) annotation(Placement(transformation(extent = {{-100, 52}, {-86, 66}})));
  Modelica.Blocks.Sources.Constant Source_TsetBedroom(k = 273.15 + 20) annotation(Placement(transformation(extent = {{-100, 30}, {-86, 44}})));
  Modelica.Blocks.Sources.Constant Source_TsetKitchen(k = 273.15 + 20) annotation(Placement(transformation(extent = {{-100, -36}, {-86, -22}})));
  Modelica.Blocks.Sources.Constant Source_TsetBath(k = 273.15 + 24) annotation(Placement(transformation(extent = {{-100, -16}, {-86, -2}})));
  Modelica.Blocks.Sources.Constant AirExWindow[5](k = 0.5) annotation(Placement(transformation(extent = {{-6, 74}, {0, 80}})));
  AixLib.HVAC.Sources.Boundary_p tank annotation(Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 270, origin = {28, -64})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(Placement(transformation(extent = {{-94, -56}, {-74, -36}})));
  inner AixLib.HVAC.BaseParameters baseParameters annotation(Placement(transformation(extent = {{80, 80}, {100, 100}})));
  Modelica.Blocks.Sources.Constant Source_TseBoiler(k = 273.15 + 55) annotation(Placement(transformation(extent = {{-86, -96}, {-72, -82}})));
  output Real Ta = combinedWeather.AirTemp;
  // Livingroom
  output Real airTLiving = VoWoWSchV1984.Appartment.Livingroom.airload.T;
  output Real radPowerLiConv = -VoWoWSchV1984.Hydraulic.Con_Livingroom.Q_flow;
  output Real radPowerLiRad = -VoWoWSchV1984.Hydraulic.Rad_Livingroom.Q_flow;
  output Real travelHVLi = VoWoWSchV1984.Hydraulic.valve_livingroom.opening;
  output Real massFlowLi = VoWoWSchV1984.Hydraulic.valve_livingroom.port_a.m_flow;
  // Bath
  output Real airTBath = VoWoWSchV1984.Appartment.Bathroom.airload.T;
  output Real radPowerBConv = -VoWoWSchV1984.Hydraulic.Con_bath.Q_flow;
  output Real radPowerBRad = -VoWoWSchV1984.Hydraulic.Rad_bath.Q_flow;
  output Real travelHVB = VoWoWSchV1984.Hydraulic.valve_bath.opening;
  output Real massFlowB = VoWoWSchV1984.Hydraulic.valve_bath.port_a.m_flow;
  // Bedroom
  output Real airTBedromm = VoWoWSchV1984.Appartment.Bedroom.airload.T;
  output Real radPowerBrConv = -VoWoWSchV1984.Hydraulic.Con_bedroom.Q_flow;
  output Real radPowerBrRad = -VoWoWSchV1984.Hydraulic.Rad_bedroom.Q_flow;
  output Real travelHVBr = VoWoWSchV1984.Hydraulic.valve_bedroom.opening;
  output Real massFlowBr = VoWoWSchV1984.Hydraulic.valve_bedroom.port_a.m_flow;
  // Children
  output Real airTChildren = VoWoWSchV1984.Appartment.Children.airload.T;
  output Real radPowerChConv = -VoWoWSchV1984.Hydraulic.Con_children.Q_flow;
  output Real radPowerChRad = -VoWoWSchV1984.Hydraulic.Rad_children.Q_flow;
  output Real travelHVCh = VoWoWSchV1984.Hydraulic.valve_children.opening;
  output Real massFlowCh = VoWoWSchV1984.Hydraulic.valve_children.port_a.m_flow;
  // Kitchen
  output Real airTKitchen = VoWoWSchV1984.Appartment.Kitchen.airload.T;
  output Real radPowerKitConv = -VoWoWSchV1984.Hydraulic.Con_kitchen.Q_flow;
  output Real radPowerKitRad = -VoWoWSchV1984.Hydraulic.Rad_kitchen.Q_flow;
  output Real travelHVKit = VoWoWSchV1984.Hydraulic.valve_kitchen.opening;
  output Real massFlowKit = VoWoWSchV1984.Hydraulic.valve_kitchen.port_a.m_flow;
equation
  connect(Pumpe.port_b, boilerTable.port_a) annotation(Line(points = {{-16, -72}, {-38, -72}, {-38, -76}, {-44, -76}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boilerTable.port_b, pipe.port_a) annotation(Line(points = {{-64, -76}, {-74, -76}, {-74, -42}, {-30, -42}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pipe.port_b, VoWoWSchV1984.Inflow) annotation(Line(points={{-18,-42},
          {-5.12727,-42},{-5.12727,-1.5}},                                                                             color = {0, 127, 255}, smooth = Smooth.None));
  connect(VoWoWSchV1984.Returnflow, pipe2.port_a) annotation(Line(points={{3.38182,
          -1.5},{3.38182,-44},{26,-44}},                                                                                 color = {0, 127, 255}, smooth = Smooth.None));
  // Here the relevant Variables for the simulation are set as output to limit the dimension of the result file
  connect(combinedWeather.WindSpeed, VoWoWSchV1984.WindSpeedPort) annotation(Line(points={{
          -48.9333,91.6},{-10.4455,91.6},{-10.4455,42.875}},                                                                                         color = {0, 0, 127}, smooth = Smooth.None));
  connect(AirExWindow.y, VoWoWSchV1984.AirExchangePort_Window) annotation(Line(points={{0.3,77},
          {6,77},{6,43.0833},{9.76364,43.0833}},                                                                                                color = {0, 0, 127}, smooth = Smooth.None));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[2], VoWoWSchV1984.SolarRadiation[1]) annotation(Line(points={{-74.32,
          72.9},{-74.32,60},{21.1091,60},{21.1091,44.5417}},                                                                                                    color = {255, 128, 0}, smooth = Smooth.None));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[4], VoWoWSchV1984.SolarRadiation[2]) annotation(Line(points={{-74.32,
          72.9},{-74.32,60},{21.1091,60},{21.1091,42.4583}},                                                                                                    color = {255, 128, 0}, smooth = Smooth.None));
  connect(combinedWeather.AirTemp, VoWoWSchV1984.air_temp) annotation(Line(points={{
          -48.9333,88.3},{-29.9455,88.3},{-29.9455,43.0833}},                                                                                  color = {0, 0, 127}, smooth = Smooth.None));
  connect(Source_TsetLivingroom.y, VoWoWSchV1984.TSet[1]) annotation(Line(points={{-85.3,
          59},{-60,59},{-60,18.7083},{-36.6818,18.7083}},                                                                                         color = {0, 0, 127}, smooth = Smooth.None));
  connect(Source_TsetBedroom.y, VoWoWSchV1984.TSet[2]) annotation(Line(points={{-85.3,
          37},{-60,37},{-60,19.9583},{-36.6818,19.9583}},                                                                                      color = {0, 0, 127}, smooth = Smooth.None));
  connect(Source_TsetChildren.y, VoWoWSchV1984.TSet[3]) annotation(Line(points={{-85.3,
          15},{-72,15},{-72,14},{-60,14},{-60,21.2083},{-36.6818,21.2083}},                                                                                           color = {0, 0, 127}, smooth = Smooth.None));
  connect(booleanExpression.y, Pumpe.IsNight) annotation(Line(points = {{-73, -46}, {-6, -46}, {-6, -61.8}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(Pumpe.port_a, tank.port_a) annotation(Line(points = {{4, -72}, {28, -72}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(tank.port_a, pipe2.port_b) annotation(Line(points = {{28, -72}, {28, -78}, {56, -78}, {56, -44}, {38, -44}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Source_TsetBath.y, VoWoWSchV1984.TSet[4]) annotation(Line(points={{-85.3,
          -9},{-60,-9},{-60,22.4583},{-36.6818,22.4583}},                                                                                   color = {0, 0, 127}, smooth = Smooth.None));
  connect(Source_TsetKitchen.y, VoWoWSchV1984.TSet[5]) annotation(Line(points={{-85.3,
          -29},{-60,-29},{-60,23.7083},{-36.6818,23.7083}},                                                                                      color = {0, 0, 127}, smooth = Smooth.None));
  connect(Source_TseBoiler.y, boilerTable.T_set) annotation(Line(points = {{-71.3, -89}, {-36, -89}, {-36, -69}, {-43.2, -69}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -140}, {100, 100}}), graphics={  Text(extent=  {{-48, -82}, {90, -168}}, lineColor=  {0, 0, 255}, textString=  "Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
 ")}), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), experimentSetupOutput(states = false, derivatives = false, auxiliaries = false, events = false), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example for setting up a simulation for an appartment.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Energy generation and delivery system consisting of boiler and pump.</p>
 <p>The example works for a day and shows how such a simulation can be set up. It is not guranteed that the model will work stable under sifferent conditions or for longer periods of time.</p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
 </ul></p>
 </html>"), Icon(coordinateSystem(extent = {{-100, -140}, {100, 100}})));
end Appartment_VoWo;
