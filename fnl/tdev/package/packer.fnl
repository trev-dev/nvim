(module tdev.package.packer
  {autoload {utils tdev.utils}})

(utils.map :<localleader>pc "PackerCompile")
(utils.map :<localleader>ps "PackerSync")
(utils.map :<localleader>pC "PackerClean")
(utils.map :<localleader>pi "PackerInstall")
