baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				configuration: 'DeepTraverser'
					with: [ spec
						versionString: #stable;
						repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main';
						loads: 'Core' ];
				configuration: 'NeoJSON'
					with: [ spec
						versionString: #stable;
						repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main';
						loads: 'Core' ];
				configuration: 'OSSubprocess'
					with: [ spec
						versionString: #stable;
						repository: 'github://marianopeck/OSSubprocess/repository' ];
				baseline: 'Mocketry' with: [ spec repository: 'github://dionisiydk/Mocketry:v4.0.x' ];
				package: 'Randy-Core' with: [ spec requires: #('DeepTraverser' 'NeoJSON') ];
				package: 'Randy-Vm' with: [ spec requires: #('Randy-Core' 'OSSubprocess') ];
				package: 'Randy-Vm-Test' with: [ spec requires: #('Randy-Vm' 'Mocketry') ].
			spec
				group: 'default' with: #('Core' 'Vm' 'Test');
				group: 'Core' with: #('Randy-Core');
				group: 'Vm' with: #('Randy-Vm');
				group: 'Test' with: #('Randy-Vm-Test') ]