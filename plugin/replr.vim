if exists("g:loaded_replr")
	finish
endif
let g:loaded_replr = 1

if !exists('g:replr_build_instructions')
	let g:replr_build_instructions = {}
endif

function! s:Replr()
	if has("unix")
		let default_build = "build.sh"
		let delimiter = '/'
	else
		let default_build = "build.bat"
		let delimiter = '\'
	endif

	let current_path = expand("%:p:h")
	let path_fragments = split(current_path, delimiter)
	let found = 0
	let i = len(path_fragments) - 1

	while i >= 0
		let dir_of_repl = join(path_fragments[0:i], delimiter)
        if has("unix")
            let dir_of_repl = "/" . dir_of_repl
        endif
		let build_script = get(g:replr_build_instructions, dir_of_repl, default_build)
		if filereadable(join([dir_of_repl, build_script], delimiter))
			let found = 1
            if has("unix")
                execute "!pushd " . dir_of_repl . " && " . "./" . build_script . " && popd"
            else
                execute "!pushd " . dir_of_repl . " && " . build_script . " && popd"
            end
			break
		endif
		let i -= 1
	endwhile

	if found == 0
		echom "No build files found!"
	endif
endfunction

command! Replr call s:Replr()
