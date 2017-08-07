symbolic versions
development: spec
   <version: 'development'>

   spec
      for: #'common'
      do: [ 
         spec
            baseline: 'Randy'
            with: [ spec repository: 'github://maenu/Randy:master' ];
            import: 'Randy' ]