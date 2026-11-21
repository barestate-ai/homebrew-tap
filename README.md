# Barestate Homebrew tap

Builds Barestate from source on your Mac. Needs read access to the barestate-ai repositories.

```sh
gh auth login && gh auth setup-git
brew install --HEAD barestate-ai/tap/barestate
ln -sfn "$(brew --prefix barestate)/Orb.app" /Applications/Orb.app
```

Upgrade with `brew upgrade --fetch-HEAD barestate`.

Install OMS with Node, Git and Solana CLI: `brew install barestate-ai/tap/oms` (`oh-my-sol` is an alias).
