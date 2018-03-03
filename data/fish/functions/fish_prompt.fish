function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	# Just calculate this once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	set -l normal (set_color normal)

	set -l color_cwd
	set -l prefix
	switch $USER
	case root toor
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		else
			set color_cwd $fish_color_cwd
		end
		set suffix '#'
	case '*'
		set color_cwd $fish_color_cwd
		set suffix '>'
	end

	set -l prompt_status
	if test $last_status -ne 0
		set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
	end

	echo -n -s (set_color $fish_color_user) "$USER" $normal @ (set_color $fish_color_host) "$__fish_prompt_hostname" $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (__fish_git_prompt) $normal $prompt_status "> "
end
