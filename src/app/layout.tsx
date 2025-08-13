// src/app/layout.tsx
import Head from 'next/head';
import { Inter } from 'next/font/google';

const inter = Inter({ subsets: ['latin'] });

export const metadata = {
  title: 'João Guilherme - Site Oficial',
  description: 'A nova voz do sertanejo pop. Confira a agenda de shows, músicas, vídeos e notícias sobre João Guilherme.',
  keywords: 'João Guilherme, sertanejo, música, shows, agenda, contratação',
  authors: [{ name: 'Equipe João Guilherme' }],
  openGraph: {
    title: 'João Guilherme - Site Oficial',
    description: 'A nova voz do sertanejo pop',
    images: [
      {
        url: '/images/joao-guilherme-hero.jpg',
        width: 1200,
        height: 630,
        alt: 'João Guilherme',
      },
    ],
    locale: 'pt_BR',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'João Guilherme - Site Oficial',
    description: 'A nova voz do sertanejo pop',
    images: ['/images/joao-guilherme-hero.jpg'],
  },
  viewport: 'width=device-width, initial-scale=1',
  robots: 'index, follow',
  icons: {
    icon: '/favicon.ico',
    apple: '/apple-touch-icon.png',
  },
  manifest: '/manifest.json',
};

export default function RootLayout({ children }) {
  return (
    <html lang="pt-BR">
      <Head>
        <meta name="google-site-verification" content="YOUR_GOOGLE_SITE_VERIFICATION" />
        <meta name="facebook-domain-verification" content="YOUR_FACEBOOK_DOMAIN_VERIFICATION" />
        
        {/* Google Analytics */}
        <script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
        <script
          dangerouslySetInnerHTML={{
            __html: `
              window.dataLayer = window.dataLayer || [];
              function gtag(){dataLayer.push(arguments);}
              gtag('js', new Date());
              gtag('config', 'GA_MEASUREMENT_ID');
            `,
          }}
        />
        
        {/* Meta Pixel */}
        <script
          dangerouslySetInnerHTML={{
            __html: `
              !function(f,b,e,v,n,t,s)
              {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
              n.callMethod.apply(n,arguments):n.queue.push(arguments)};
              if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
              n.queue=[];t=b.createElement(e);t.async=!0;
              t.src=v;s=b.getElementsByTagName(e)[0];
              s.parentNode.insertBefore(t,s)}(window, document,'script',
              'https://connect.facebook.net/en_US/fbevents.js');
              fbq('init', 'YOUR_PIXEL_ID');
              fbq('track', 'PageView');
            `,
          }}
        />
        <noscript>
          <img
            height="1"
            width="1"
            style={{ display: 'none' }}
            src={`https://www.facebook.com/tr?id=YOUR_PIXEL_ID&ev=PageView&noscript=1`}
          />
        </noscript>
      </Head>
      <body className={inter.className}>
        {children}
      </body>
    </html>
  );
}
