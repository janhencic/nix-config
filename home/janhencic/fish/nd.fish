function nd
  if test (count $argv) -eq 0
    nix develop -c fish
  else
    nix develop $argv -c fish
  end
end

function fzf_tmux_session
    set -l target_session (tmux list-sessions | fzf)
end

function fish_user_key_bindings
  bind \cs fzf_tmux_session
end

fish_user_key_bindings
