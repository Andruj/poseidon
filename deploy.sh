pub build
rm -rf ../andruj.github.io/*
cp -R build/web/* ../andruj.github.io/
cd ../andruj.github.io
git add --all
git commit -am 'New deploy.'
git push
cd ../poseidon
