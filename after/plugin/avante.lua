require('snacks').setup()
--require('dressing').setup()

require("avante").setup({
    provider = "openai",                  -- Set OpenAI as the default provider
    auto_suggestions_provider = "openai", -- Ensure auto-suggestions use OpenAI
    --provider = "copilot",                  -- Set Copilot as the default provider
    --auto_suggestions_provider = "copilot", -- Ensure auto-suggestions use Copilot
    mode = "agentic",
    providers = {
        openai = {
            enabled = true,
            model = "gpt-4o",
        },
        --copilot = {
        --    enabled = true,
        --    model = "gpt-4o",
        --},
    },
    dual_boost = {
        enabled = false,
        first_provider = "openai", -- Use OpenAI as the first provider
        --second_provider = "copilot", -- Use Copilot as the second provider
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
