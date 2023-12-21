# shellcheck shell=sh
# shellcheck source=/dev/null

# Do not continue if run directly, rather than being sourced.
# if [ ! "$0" != "$_" ]; then
#     return 0
# fi

# Function to run a specified command (optionally with parameters), then test
#   if completed successfully, if not true then break out of script.
function _commandok() {
    if ! $* 2>/dev/null; then return 0; fi
}

# Function to unset an existing environment variable, and then set it anew
# with the specified value.
function _envclobber() {
    xENVARR=($*)
    for xENV in "${xENVARR[@]}" ; do
        _commandok "unset -v ${xENV%%:*}"
        _commandok "mkdir --parents "${xENV#*:}""
        export "${xENV%%:*}"="${xENV#*:}"
    done
}

# Function to prepend a unique value to an existing environment variable.
function _envprepend() {
    xENVARR=($*)
    for xENV in "${xENVARR[@]}" ; do
        _commandok "mkdir --parents "${xENV#*:}""
        
    done
}

# Create symlinks with hirearchy for files that have been created by vendor
#   as means of standardising configuration across like instances.
function copy_zzz() {
    updatedb &>/dev/null
    local FILES=(
        $(cat "${HOME}/.custom/.addl_files")
        $(locate -b zzz-94v1c8 | grep -Ev "^${HOME}")
    )
    for FILE in ${FILES[*]}; do
        mkdir -p "${HOME}/.custom/$(dirname ${FILE})" &>/dev/null
        ln -sv "${FILE}" "${HOME}/.custom${FILE}" 2>/dev/null
    done
}
