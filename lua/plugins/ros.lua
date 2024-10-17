return {
    'thibthib18/ros-nvim', --https://github.com/thibthib18/ros-nvim
    event = "VeryLazy",
    keys = {
        { "<leader>Rtl",  "<cmd>lua require('ros-nvim.telescope.pickers').topic_picker()<cr>",   desc = "ROS: [R]os[t]opic [l]ist",     mode = { "n" } },
        { "<leader>Rnl",  "<cmd>lua require('ros-nvim.telescope.pickers').node_picker()<cr>",    desc = "ROS: [R]os[n]opic [l]ist",     mode = { "n" } },
        { "<leader>Rsl",  "<cmd>lua require('ros-nvim.telescope.pickers').service_picker()<cr>", desc = "ROS: [R]os[s]ervice [l]ist",   mode = { "n" } },
        { "<leader>Rsrv", "<cmd>lua require('ros-nvim.telescope.pickers').srv_picker()<cr>",     desc = "ROS: [R]os [srv]",             mode = { "n" } },
        { "<leader>Rmsg", "<cmd>lua require('ros-nvim.telescope.pickers').msg_picker()<cr>",     desc = "ROS: [R]os [msg]",             mode = { "n" } },
        { "<leader>Rp",   "<cmd>lua require('ros-nvim.telescope.pickers').param_picker()<cr>",   desc = "ROS: [R]os [p]aram",           mode = { "n" } },
        -- { "<leader>RPg",  "<cmd>lua require('ros-nvim.telescope.package').grep_package()<cr>",   desc = "ROS: [R]os [P]ackage [g]rep",  mode = { "n" } },
        -- { "<leader>RPf",  "<cmd>lua require('ros-nvim.telescope.package').search_package()<cr>", desc = "ROS: [R]os [P]ackage [f]ind",  mode = { "n" } },
        -- { "<leader>Rcb",  "<cmd>lua require('ros-nvim.build').catkin_make()<cr>",                desc = "ROS: [R]os [c]atkin [b]uild",  mode = { "n" } },
        -- { "<leader>RPb",  "<cmd>lua require('ros-nvim.build').catkin_make_pkg()<cr>",            desc = "ROS: [R]os [P]ackage [b]uild", mode = { "n" } },
    },
    config = function()
        local vim_utils = require "ros-nvim.vim-utils"
        require 'ros-nvim'.setup({
            -- make program (e.g. "catkin_make" or "catkin build" )
            -- catkin_program = "catkin build"
        })
    end

}
