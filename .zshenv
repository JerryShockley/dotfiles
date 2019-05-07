#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Openssl options
LDFLAGS="-L/usr/local/opt/openssl/lib"
CPPFLAGS="-I/usr/local/opt/openssl/include"
PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# A CA file has been bootstrapped using certificates from the SystemRoots
# keychain. To add additional certificates (e.g. the certificates added in
# the System keychain), place .pem files in
#  /usr/local/etc/openssl/certs
# and run
#  /usr/local/opt/openssl/bin/c_rehash<Paste>
#  ,e
#

# Zlib (homebrew) compile options
LDFLAGS=$LDFLAGS:/usr/local/opt/zlib/lib
CPPFLAGS=$CPPFLAGS:/usr/local/opt/zlib/include
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/zlib/lib/pkgconfig

    
# Sqlite options
LDFLAGS=$LDFLAGS:usr/local/opt/sqlite/lib
CPPFLAGS=$CPPFLAGS:/usr/local/opt/sqlite/include
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/sqlite/lib/pkgconfig

# Set FZF environment variables
FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

