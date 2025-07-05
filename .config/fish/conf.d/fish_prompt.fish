# Docs about writing your own prompt: https://fishshell.com/docs/current/prompt.html
function fish_prompt
        set -l last_status $status
        set -l normal (set_color normal)
        set -l status_color (set_color brcyan)
        set -l cwd_color (set_color $fish_color_cwd)
        set -l vcs_color (set_color brblue)
        set -l prompt_status ""
        set -l dotfiles_branch_color (set_color brpurple) # purple
        set -l dotfiles_branch (git --git-dir=$HOME/.cfg --work-tree=$HOME branch --show-current)

        # Since we display the prompt on a new line allow the directory names to be longer.
        set -q fish_prompt_pwd_dir_length
        or set -lx fish_prompt_pwd_dir_length 0

        # Color the prompt differently when we're root
        set -l suffix '❯'
        if functions -q fish_is_root_user; and fish_is_root_user
                if set -q fish_color_cwd_root
                        set cwd_color (set_color $fish_color_cwd_root)
                end
                set suffix '#'
        end

        # Color the prompt in red on error
        if test $last_status -ne 0
                set status_color (set_color $fish_color_error)
                set prompt_status $status_color "[" $last_status "]" $normal
        end

        echo -s $dotfiles_branch_color [$dotfiles_branch] $normal ' ' (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
        echo -n -s $status_color $suffix ' ' $normal
end
