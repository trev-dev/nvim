(module tdev.package.packer
  {autoloads {utils tdev.utils}})

(utils.map :<leader>pc "PackerCompile")
(utils.map :<leader>ps "PackerSync")
(utils.map :<leader>pC "PackerClean")
(utils.map :<leader>pi "PackerInstall")
