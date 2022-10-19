export PATH=$PATH:/Users/wladknd/.nvm/versions/node/v18.10.0/bin
cd /Volumes/LIB/IT/CODE
mkdir $1
cd /Volumes/LIB/IT/CODE/$1
npm init -y 
npm i react react-dom next styled-components dotenv
npm i -D typescript @types/node @types/react @types/styled-components
./node_modules/.bin/tsc --init  

mkdir public && cd public && mkdir fonts && cd fonts

echo "@font-face {
    font-family: 'Poppins-Regular';
    src: url('./Poppins-Regular.ttf');
    font-weight: 900;
    font-style: normal;
    font-size: 50px;
}" > fonts.css

cd ../../

mkdir components

cp /Volumes/LIB/IT/CODE/newComponent.sh ./

mkdir pages && cd pages 

echo "import React from 'react'

const Home = () => {
  return (
    <div>
        HOME
    </div>
  )
}

export default Home" > index.tsx

echo "import type { AppProps } from 'next/app'

function MyApp({ Component, pageProps}: AppProps) {
  return <Component {...pageProps} />
}

// Only uncomment this method if you have blocking data requirements for
// every single page in your application. This disables the ability to
// perform automatic static optimization, causing every page in your app to
// be server-side rendered.
//
// MyApp.getInitialProps = async (appContext) => {
//   // calls page's  and fills 
//   const appProps = await App.getInitialProps(appContext);
//
//   return { ...appProps }
// }

export default MyApp" > _app.tsx

echo " import Document, { DocumentContext, DocumentInitialProps } from 'next/document'
import { ServerStyleSheet } from 'styled-components'
export default class MyDocument extends Document {
  static async getInitialProps(
    ctx: DocumentContext
  ): Promise<DocumentInitialProps> {
    const sheet = new ServerStyleSheet()
    const originalRenderPage = ctx.renderPage

    try {
      ctx.renderPage = () =>
        originalRenderPage({
          enhanceApp: (App) => (props) =>
            sheet.collectStyles(<App {...props} />),
        })

      const initialProps = await Document.getInitialProps(ctx)
      return {
        ...initialProps,
        styles: (
          <>
            {initialProps.styles}
            {sheet.getStyleElement()}
          </>
        ),
      }
    } finally {
      sheet.seal()
    }
  }
}" > document.js
         
cd ../
echo "const nextConfig = {
  reactStrictMode: true,
  compiler: {
    styledComponents: true,
  },
}

module.exports = nextConfig" > next.config.js

/usr/local/bin/jq '. + {"scripts": {"dev": "next dev", "start": "next start", "build": "next build",
"component": "./newComponent.sh $npm_config_name"}}' package.json > temp.json && mv temp.json package.json

open -a 'Visual Studio Code' "/Volumes/LIB/IT/CODE/$1"
open -a 'iTerm' "/Volumes/LIB/IT/CODE/$1"
open -a 'Google Chrome' "http://localhost:3000/" 
return $1