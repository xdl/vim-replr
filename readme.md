# Replr

Quick and dirty Vim plugin for tightening REPLs.

Calling with `:Replr`, will try and find the first file called `build.bat` (or `build.sh` on Unix) and execute it, located as a sibling or in any of the parent directories of the `cwd`.

Define custom script file to find in `vimrc` something like:

	let g:replr_build_instructions = {
		\ "absolute_path_to_dir": "go.bat"
		\}
