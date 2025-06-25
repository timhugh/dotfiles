local org_dir = vim.fn.expand('~/org/')

return {
  {
    'nvim-orgmode/orgmode',
    enabled = true,
    event = 'VeryLazy',
    ft = { 'org' },
    opts = {
      org_agenda_files = { org_dir .. '/**/*' },
      org_default_notes_file = org_dir .. 'todo.org',
      org_todo_keywords = { 'TODO(t)', 'IN-PROGRESS(i)', '|', 'DONE(d)', 'SKIPPED(s)', 'MIGRATED(m)' },
      org_startup_indented = true,
      org_agenda_span = 'day',
      org_log_done = false,
      org_log_repeat = false,
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n SCHEDULED: %t',
          target = org_dir .. 'roam/daily/%<%Y>-%<%m>-%<%d>.org',
        },
        j = {
          description = 'Journal',
          template = '* %U %?\n',
          target = org_dir .. 'roam/daily/%<%Y>-%<%m>-%<%d>.org',
        },
      },
    },
  },
  {
    "chipsenkbeil/org-roam.nvim",
    dependencies = { 'nvim-orgmode/orgmode' },
    opts = {
      directory = org_dir .. 'roam/',
    },
  },
  {
    'nvim-orgmode/org-bullets.nvim',
    opts = {},
  },
}
