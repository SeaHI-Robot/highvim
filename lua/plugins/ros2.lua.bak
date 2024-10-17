return {
    "ErickKramer/nvim-ros2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>Rte", "<cmd>Telescope ros2 topics_echo<cr>", desc = "ROS2: [R]os2 [t]opic [e]cho]",  mode = { "n" } }, -- This function has a bug, topic echos whill only display once
        { "<leader>Rti", "<cmd>Telescope ros2 topics_info<cr>", desc = "ROS2: [R]os2 [t]opic [i]nfo]",  mode = { "n" } },
        { "<leader>Rn",  "<cmd>Telescope ros2 nodes<cr>",       desc = "ROS2: [R]os2 [n]ode list",      mode = { "n" } },
        { "<leader>Ra",  "<cmd>Telescope ros2 actions<cr>",     desc = "ROS2: [R]os2 [a]ction list",    mode = { "n" } },
        { "<leader>Rs",  "<cmd>Telescope ros2 services<cr>",    desc = "ROS2: [R]os2 [s]ervice list",   mode = { "n" } },
        { "<leader>Ri",  "<cmd>Telescope ros2 interfaces<cr>",  desc = "ROS2: [R]os2 [i]nterface list", mode = { "n" } },
    },
    opts = {
        -- Add any custom options here
        autocmds = true,
        telescope = true,
        treesitter = true,
    }
}
