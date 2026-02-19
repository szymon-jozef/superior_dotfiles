function update --description "update system"
    echo "===System update==="
    if not yay
        sudo pacman -Syu
    end

    echo "===Remove orphans==="
    set orphans (pacman -Qtdq)
    if test (count $orphans) -gt 0
        sudo pacman -Rns $orphans
    end

    echo "===Flatpak update==="
    flatpak update --noninteractive
    echo "===Flatpak remove unused==="
    flatpak uninstall --unused
    echo "===Nix update==="
    nix-channel --update
    home-manager switch
    echo "===Nix garbage collection==="
    home-manager expire-generations "-7 days"
end
