require('snacks').setup()
--require('dressing').setup()

require("avante").setup({
    provider = "copilot",                  -- Set OpenAI as the default provider
    auto_suggestions_provider = "copilot", -- Ensure auto-suggestions use OpenAI
    mode = "agentic",
    providers = {
        copilot = {
            enabled = true,
            model = "gpt-4o",
        },
    },
    dual_boost = {
        enabled = false,
    },
    input = {
        provider = "snacks",
        provider_opts = {
            title = "Avante Input",
            icon = "i",
            placeholder = "Enter your API key...",
        },
    },
})
