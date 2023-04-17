# Jack2

cd $ZYNTHIAN_SW_DIR

SW_DIR="jack2"
if [ -d "$SW_DIR" ]; then
	rm -rf "$SW_DIR"
fi

echo "The current directory is: $(pwd)"
echo "Cloning jack2 into $ZYNTHIAN_SW_DIR / $SW_DIR"

git clone --branch v1.9.22 https://github.com/jackaudio/jack2.git $SW_DIR
cd jack2
./waf configure
./waf build
./waf install 
./waf clean

cd ..
#rm -rf "$SW_DIR"
