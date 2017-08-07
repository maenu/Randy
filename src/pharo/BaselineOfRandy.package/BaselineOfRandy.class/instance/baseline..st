baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				configuration: 'DeepTraverser'
					with: [ spec
						versionString: #development;
						repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main' ];
				configuration: 'NeoJSON'
					with: [ spec
						versionString: #stable;
						repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ];
				configuration: 'OSSubprocess'
					with: [ spec
						versionString: #stable;
						repository: 'github://marianopeck/OSSubprocess/repository' ];
				package: 'Randy-Core' with: [ spec requires: #('DeepTraverser' 'NeoJSON') ];
				package: 'Randy-Remote' with: [ spec requires: #('Randy-Core' 'OSSubprocess') ] ]