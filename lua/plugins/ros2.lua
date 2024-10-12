return {
    'SeaHI-Robot/ros2-nvim', --https://github.com/thibthib18/ros-nvim
    event = "VeryLazy",
    keys = {
        { "<leader>Rtl",  "<cmd>lua require('ros2-nvim.telescope.pickers').topic_picker()<cr>",   desc = "ROS2: [R]os2 [t]opic [l]ist",   mode = { "n" } },
        { "<leader>Rnl",  "<cmd>lua require('ros2-nvim.telescope.pickers').node_picker()<cr>",    desc = "ROS2: [R]os2 [n]opic [l]ist",   mode = { "n" } },
        { "<leader>Rsl",  "<cmd>lua require('ros2-nvim.telescope.pickers').service_picker()<cr>", desc = "ROS2: [R]os2 [s]ervice [l]ist", mode = { "n" } },
        { "<leader>Rsrv", "<cmd>lua require('ros2-nvim.telescope.pickers').srv_picker()<cr>",     desc = "ROS2: [R]os2 [srv] list",       mode = { "n" } },
        { "<leader>Rmsg", "<cmd>lua require('ros2-nvim.telescope.pickers').msg_picker()<cr>",     desc = "ROS2: [R]os2 [msg] list",       mode = { "n" } },
        { "<leader>Rp",   "<cmd>lua require('ros2-nvim.telescope.pickers').param_picker()<cr>",   desc = "ROS2: [R]os2 [p]aram list",     mode = { "n" } },
    },
    config = function()
        -- local vim_utils = require "ros2-nvim.vim-utils"
        require 'ros2-nvim'.setup({
            -- make program (e.g. "catkin_make" or "catkin build" )
            -- catkin_program = "catkin build"
        })
    end

}
