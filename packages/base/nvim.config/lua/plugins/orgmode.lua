return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    opts = {
      org_agenda_files = { '~/org/**/*' },
      org_default_notes_file = '~/org/journal.org',
      org_todo_keywords = { 'TODO(t)', 'IN-PROGRESS(i)', '|', 'DONE(d)', 'SKIPPED(s)', 'MIGRATED(m)' },
      org_startup_indented = true,
    },
  },
}
