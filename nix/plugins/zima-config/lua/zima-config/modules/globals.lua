return kzn.modules.create({
	name = 'globals',
	---@class GlobalsConfig
	config = {
		leader = 'string',
		localleader = 'string',
	},
	---@param config GlobalsConfig
	entry = function(config)
		vim.g.mapleader = config.leader
		vim.g.maplocalleader = config.leader
	end,
})
