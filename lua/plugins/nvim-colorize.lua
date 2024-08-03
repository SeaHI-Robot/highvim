return {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
        require('colorizer').setup()
        require('colorizer').attach_to_buffer(0)
    end

    
}
