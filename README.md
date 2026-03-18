# factorio-helicopters
"HelicopterRevival" mod for Factorio. [Mod Portal Link](<https://mods.factorio.com/mods/twilightthepony/HelicopterRevival>)

Original (Helicopters) by [Kumpu](<https://github.com/kumpuu/factorio-helicopters>)

## API Feature
In version 0.6.0 an open access API was added to enable other mod authors to register new helicopter entities that get handled the same way as the default helicopters that this mod adds. (starting, landing, send to locations, etc.)

### API Call
1. Have this mod as dependency
   - a mod option to disable the default helicopters exists. So there is an API-only way of using this framework.
2. Require the `"heliMaker"` file, which sits at this mod's root. (`require("__HelicopterRevival__.heliMaker"`))
3. Call `HRHelicopterMaker(args)` and provide the optional and required arguments in the `args` parameter.
   - Required:
     - **name** *(name of the helicopter, which will end up as a prefix)*
     - **icon** *(icon of the helicopter)*
     - **iconSize** *(corresponding icon size)*
     - **selBox** *(selection_box of the helicopter)*
     - **colBox** *(collision_box of the helicopter)*
     - **animation** *(RotatedAnimation of the helicopter torso; no shadows!)*
     - **animationShadow** *(RotatedAnimation of the helicopter torso; only shadows!)*
     - **animationRotor** *(RotatedAnimation of the helicopter rotors; no shadows!)*
     - **animationRotorShadow** *(RotatedAnimation of the helicopter rotors; only shadows!)*
     - **entityProperties** *(properties of the heli entity; contains its own set of required properties for the car prototype, everything else is optional (max_health, energy_per_hit_point, rotation_speed, turret_rotation_speed, inventory_size, weight, effectivity, consumption, braking_power, friction, energy_source, animation))*
   - Optional:
     - **light** *(light of the heli)*
     - **crashTrigger** *(crash_trigger of the heli)*
     - **animationTurret** *(RotatedAnimation of the helicopter turret; no shadows!; will be drawn below the torso)*
     - **animationTurretShadow** *(RotatedAnimation of the helicopter turret; only shadows!; will be drawn below the torso)*
     - **smoke** *(table of smoke definitions to be used in the burner)*
     - **smokePositions** *(alternative to `smoke`; table of pos and height; height is smoke height and pos is table of positions; both are being used to create a table of smokes of the default heli smoke that comes with this mod)*
     - **bobbing** *(boolean; should the heli generally be allowed to bob when hovering)*
     - **workingSound** *(working_sound of the heli)*
4. Done. The framework will create the entities and register them automatically in control stage.

### Your own effort
You need to add an item that places the helicopter placement entity. (place_result = "[your heli name]-helicopter")

You need to add locale for the entities: "[your heli name]-helicopter" => heli item/entity"

Technologies and recipes are up to you.