include "${KW_LIB_DIR}/lib/kwio.sh"
include "${KW_LIB_DIR}/lib/kwlib.sh"

function kworkflow_help()
{
  printf '%s\n' 'Usage: kw [options]' \
    '' \
    'The current supported targets are:' \
    '  Host - this machine' \
    '  Remote - machine reachable via the network' \
    '' \
    'Commands:' \
    '  init - Initialize kworkflow config file' \
    '  build,b - Build kernel' \
    '  deploy,d - Deploy a new kernel image to a target machine' \
    '  bd - Build and install kernel image/modules' \
    '  diff,df - Diff files' \
    '  ssh,s - SSH support' \
    '  vars - Show kw variables' \
    '  codestyle,c - Apply checkpatch on directory or file' \
    '  self-update,u - kw self-update mechanism' \
    '  maintainers,m - Get maintainers and mailing list' \
    '  kernel-config-manager,k - Manage kernel .config files' \
    '  config,g - Set kw config options' \
    '  remote - Manage machines available via ssh' \
    '  explore,e - Explore string patterns' \
    '  pomodoro,p - kw pomodoro support' \
    '  report,r - Show kw pomodoro reports and kw usage statistics' \
    '  device - Show basic hardware information' \
    '  backup - Save or restore kw data' \
    '  debug - Linux kernel debug utilities' \
    '  mail - Send patches via email' \
    '  env - Handle kw envs' \
    '  patch-hub - Interface to lore kernel' \
    '  clear-cache - Clear files generated by kw' \
    '  drm - Set of commands to work with DRM drivers' \
    '  vm - Basic support for QEMU image' \
    '  version,--version,-v - Show kw version' \
    '  man - Show manual pages' \
    '  h,-h - Displays this help message' \
    '  help,--help - Show kw man page'
}

# Display the man documentation that is built on install
function kworkflow_man()
{
  feature="$1"
  flag=${2:-'SILENT'}
  doc="$KW_MAN_DIR"

  if [[ -z "$feature" ]]; then
    feature='kw'
  else
    feature="kw-${feature}"
  fi

  if [[ -f "$KW_SYSTEM_WIDE_INSTALLATION" ]]; then
    cmd_manager "$flag" "man ${feature}"
    exit "$?"
  fi

  if [[ -r "$doc/$feature.1" ]]; then
    cmd_manager "$flag" "man -l $doc/$feature.1"
    exit "$?"
  fi

  complain "Couldn't find the man page for $feature!"
  exit 2 # ENOENT
}

function kworkflow_version()
{
  local version_path="$KW_LIB_DIR/VERSION"

  cat "$version_path"
}
