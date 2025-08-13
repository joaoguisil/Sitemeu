#!/bin/bash

# Script para criar o site do João Guilherme automaticamente
# Execute com: bash criar_site.sh

# Cores para saída no terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para exibir mensagens de status
status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCESSO]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

# Verificar se o git está instalado
if ! command -v git &> /dev/null; then
    error "Git não está instalado. Instale com: pkg install git"
    exit 1
fi

# Verificar se o node está instalado
if ! command -v node &> /dev/null; then
    error "Node.js não está instalado. Instale com: pkg install nodejs"
    exit 1
fi

# Verificar se o npm está instalado
if ! command -v npm &> /dev/null; then
    error "npm não está instalado. Instale com: pkg install npm"
    exit 1
fi

# Início do script
status "Iniciando configuração do site do João Guilherme..."

# Criar diretório do projeto
status "Criando diretório do projeto..."
mkdir -p sitemeu
cd sitemeu
success "Diretório criado com sucesso!"

# Inicializar repositório git
status "Inicializando repositório git..."
git init
success "Repositório git inicializado!"

# Criar projeto Next.js
status "Criando projeto Next.js..."
npx create-next-app@latest . --typescript --tailwind --app --src-dir --import-alias "@/*" --no-git
success "Projeto Next.js criado!"

# Instalar dependências adicionais
status "Instalando dependências adicionais..."
npm install @next/font @next/pwa firebase mailchimp-api-v3 react-icons framer-motion swiper
success "Dependências instaladas!"

# Criar estrutura de diretórios
status "Criando estrutura de diretórios..."
mkdir -p src/components src/lib public/images .github/workflows
success "Estrutura de diretórios criada!"

# Criar arquivo next.config.js
status "Configurando Next.js..."
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  trailingSlash: true,
  images: {
    unoptimized: true,
  },
  // Configurações para o caminho base
  basePath: '/sitemeu',
  assetPrefix: '/sitemeu',
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'Referrer-Policy',
            value: 'origin-when-cross-origin',
          },
        ],
      },
    ];
  },
  async rewrites() {
    return [
      {
        source: '/sw.js',
        destination: '/_next/static/chunks/sw.js',
      },
    ];
  },
};

module.exports = nextConfig;
EOF
success "Arquivo next.config.js criado!"

# Criar arquivo tailwind.config.js
status "Configurando Tailwind CSS..."
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        'black-primary': '#0B0B0B',
        'gray-primary': '#1E1E1E',
        'blue-dark': '#0A3D62',
        'blue-light': '#2E86DE',
      },
      backgroundImage: {
        'gradient-dark': 'linear-gradient(to right, #0B0B0B, #0A3D62)',
      },
    },
  },
  plugins: [],
}
EOF
success "Arquivo tailwind.config.js criado!"

# Criar arquivo de layout
status "Criando arquivo de layout..."
mkdir -p src/app
cat > src/app/layout.tsx << 'EOF'
import { Inter } from 'next/font/google';
import Head from 'next/head';

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
        url: '/sitemeu/images/joao-guilherme-hero.jpg',
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
    images: ['/sitemeu/images/joao-guilherme-hero.jpg'],
  },
  viewport: 'width=device-width, initial-scale=1',
  robots: 'index, follow',
  icons: {
    icon: '/sitemeu/favicon.ico',
    apple: '/sitemeu/apple-touch-icon.png',
  },
  manifest: '/sitemeu/manifest.json',
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
EOF
success "Arquivo de layout criado!"

# Criar página principal
status "Criando página principal..."
cat > src/app/page.tsx << 'EOF'
import Header from '@/components/Header';
import Hero from '@/components/Hero';
import Player from '@/components/Player';
import Agenda from '@/components/Agenda';
import Contratacao from '@/components/Contratacao';
import FanClub from '@/components/FanClub';
import Blog from '@/components/Blog';
import Patrocinadores from '@/components/Patrocinadores';
import Chatbot from '@/components/Chatbot';
import Footer from '@/components/Footer';

export default function Home() {
  return (
    <div className="min-h-screen bg-black-primary text-white">
      <Header />
      <Hero />
      <Player />
      <Agenda />
      <Contratacao />
      <FanClub />
      <Blog />
      <Patrocinadores />
      <Footer />
      <Chatbot />
    </div>
  );
}
EOF
success "Página principal criada!"

# Criar componentes
status "Criando componentes..."

# Componente Header
cat > src/components/Header.tsx << 'EOF'
import { useState } from 'react';
import Link from 'next/link';

export default function Header() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <header className="fixed top-0 w-full bg-gradient-to-r from-black-primary to-blue-dark z-50 shadow-lg">
      <div className="container mx-auto px-4 py-3 flex justify-between items-center">
        <Link href="/" className="text-white text-2xl font-bold">
          João Guilherme
        </Link>
        
        {/* Desktop Menu */}
        <nav className="hidden md:flex space-x-8">
          {['Início', 'Agenda', 'Músicas', 'Contratação', 'Blog', 'Contato'].map((item) => (
            <Link 
              key={item} 
              href={`#${item.toLowerCase()}`} 
              className="text-white hover:text-blue-light transition-colors"
            >
              {item}
            </Link>
          ))}
        </nav>
        
        {/* CTA Button */}
        <a 
          href="https://wa.me/5511999999999?text=Olá, gostaria de reservar um show com o João Guilherme" 
          target="_blank" 
          rel="noopener noreferrer"
          className="bg-blue-light text-white px-6 py-2 rounded-full font-semibold hover:bg-blue-600 transition-colors"
        >
          Reservar Show
        </a>
        
        {/* Mobile Menu Button */}
        <button 
          className="md:hidden text-white"
          onClick={() => setIsMenuOpen(!isMenuOpen)}
        >
          <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
      </div>
      
      {/* Mobile Menu */}
      {isMenuOpen && (
        <div className="md:hidden bg-black-primary py-4 px-4">
          <div className="flex flex-col space-y-3">
            {['Início', 'Agenda', 'Músicas', 'Contratação', 'Blog', 'Contato'].map((item) => (
              <Link 
                key={item} 
                href={`#${item.toLowerCase()}`} 
                className="text-white hover:text-blue-light transition-colors"
                onClick={() => setIsMenuOpen(false)}
              >
                {item}
              </Link>
            ))}
          </div>
        </div>
      )}
    </header>
  );
}
EOF

# Componente Hero
cat > src/components/Hero.tsx << 'EOF'
import Link from 'next/link';

export default function Hero() {
  return (
    <section className="relative pt-24 pb-20 md:pt-32 md:pb-28 bg-gradient-to-b from-black-primary to-gray-primary">
      <div className="container mx-auto px-4">
        <div className="flex flex-col md:flex-row items-center">
          <div className="md:w-1/2 mb-10 md:mb-0">
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-4">
              João Guilherme – <span className="text-blue-light">A nova voz do sertanejo pop</span>
            </h1>
            <p className="text-gray-300 mb-8 text-lg">Sua próxima atração está aqui.</p>
            <div className="flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4">
              <a 
                href="https://open.spotify.com/artist/ID" 
                target="_blank" 
                rel="noopener noreferrer"
                className="bg-blue-light text-white px-8 py-3 rounded-full font-semibold hover:bg-blue-600 transition-colors flex items-center justify-center"
              >
                <span className="mr-2">▶</span> Ouça Agora
              </a>
              <a 
                href="https://wa.me/5511999999999?text=Olá, gostaria de reservar um show com o João Guilherme" 
                target="_blank" 
                rel="noopener noreferrer"
                className="bg-transparent border-2 border-blue-light text-blue-light px-8 py-3 rounded-full font-semibold hover:bg-blue-light hover:text-black-primary transition-colors flex items-center justify-center"
              >
                <span className="mr-2">🎫</span> Reserve Seu Show
              </a>
            </div>
          </div>
          <div className="md:w-1/2 flex justify-center">
            <div className="relative">
              <div className="absolute -inset-4 bg-blue-light rounded-full opacity-20 blur-xl"></div>
              <img 
                src="/sitemeu/images/joao-guilherme-hero.jpg" 
                alt="João Guilherme" 
                className="relative rounded-2xl shadow-2xl w-full max-w-md"
              />
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
EOF

# Componente Player
cat > src/components/Player.tsx << 'EOF'
import { useState } from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import { Navigation, Pagination } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

export default function Player() {
  const [isPlaying, setIsPlaying] = useState(false);

  const videos = [
    { id: 1, title: "Show em São Paulo", thumbnail: "/sitemeu/images/video1.jpg" },
    { id: 2, title: "Clipe Oficial - Nova Música", thumbnail: "/sitemeu/images/video2.jpg" },
    { id: 3, title: "Entrevista Exclusiva", thumbnail: "/sitemeu/images/video3.jpg" },
    { id: 4, title: "Nos Estúdios de Gravação", thumbnail: "/sitemeu/images/video4.jpg" },
  ];

  return (
    <section className="py-20 bg-gray-primary">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">Músicas e Vídeos</h2>
          <p className="text-gray-400 max-w-2xl mx-auto">Play e Sinta a Emoção</p>
        </div>
        
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          {/* Spotify Player */}
          <div className="bg-black-primary rounded-2xl p-6 shadow-xl">
            <div className="flex items-center justify-between mb-6">
              <h3 className="text-xl font-semibold text-white">Ouça no Spotify</h3>
              <button 
                onClick={() => setIsPlaying(!isPlaying)}
                className="bg-blue-light text-white w-12 h-12 rounded-full flex items-center justify-center hover:bg-blue-600 transition-colors"
              >
                {isPlaying ? (
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 9v6m4-6v6m7-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                ) : (
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                )}
              </button>
            </div>
            
            <div className="space-y-4">
              {[1, 2, 3].map((item) => (
                <div key={item} className="flex items-center p-3 rounded-lg hover:bg-gray-primary transition-colors">
                  <div className="mr-4">
                    <div className="w-12 h-12 bg-blue-dark rounded-lg flex items-center justify-center">
                      <span className="text-white font-bold">{item}</span>
                    </div>
                  </div>
                  <div className="flex-1">
                    <h4 className="text-white font-medium">Música {item}</h4>
                    <p className="text-gray-400 text-sm">Álbum: Novo Sertanejo</p>
                  </div>
                  <div className="text-gray-400">
                    3:{item}0
                  </div>
                </div>
              ))}
            </div>
            
            <div className="mt-6 flex justify-center">
              <a 
                href="https://open.spotify.com/artist/ID" 
                target="_blank" 
                rel="noopener noreferrer"
                className="text-blue-light hover:text-blue-400 flex items-center"
              >
                Ver no Spotify
                <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 ml-1" viewBox="0 0 20 20" fill="currentColor">
                  <path fillRule="evenodd" d="M12.586 4.586a2 2 0 112.828 2.828l-3 3a2 2 0 01-2.828 0 1 1 0 00-1.414 1.414 4 4 0 005.656 0l3-3a4 4 0 00-5.656-5.656l-1.5 1.5a1 1 0 101.414 1.414l1.5-1.5zm-5 5a2 2 0 012.828 0 1 1 0 101.414-1.414 4 4 0 00-5.656 0l-3 3a4 4 0 105.656 5.656l1.5-1.5a1 1 0 10-1.414-1.414l-1.5 1.5a2 2 0 11-2.828-2.828l3-3z" clipRule="evenodd" />
                </svg>
              </a>
            </div>
          </div>
          
          {/* Video Carousel */}
          <div>
            <Swiper
              modules={[Navigation, Pagination]}
              spaceBetween={20}
              slidesPerView={1}
              navigation
              pagination={{ clickable: true }}
              breakpoints={{
                640: {
                  slidesPerView: 2,
                },
              }}
              className="video-swiper"
            >
              {videos.map((video) => (
                <SwiperSlide key={video.id}>
                  <div className="relative rounded-xl overflow-hidden shadow-lg group cursor-pointer">
                    <img src={video.thumbnail} alt={video.title} className="w-full h-48 object-cover" />
                    <div className="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                      <div className="w-16 h-16 bg-blue-light rounded-full flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8 text-white" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM9.555 7.168A1 1 0 008 8v4a1 1 0 001.555.832l3-2a1 1 0 000-1.664l-3-2z" clipRule="evenodd" />
                        </svg>
                      </div>
                    </div>
                    <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black to-transparent p-4">
                      <h3 className="text-white font-medium">{video.title}</h3>
                    </div>
                  </div>
                </SwiperSlide>
              ))}
            </Swiper>
          </div>
        </div>
      </div>
    </section>
  );
}
EOF

# Componente Agenda
cat > src/components/Agenda.tsx << 'EOF'
import { useState } from 'react';

export default function Agenda() {
  const [activeTab, setActiveTab] = useState('proximos');
  
  const shows = [
    { id: 1, date: '15/07/2023', city: 'São Paulo', location: 'Allianz Parque', tickets: 'https://example.com/tickets1', map: 'https://maps.google.com/?q=Allianz+Parque' },
    { id: 2, date: '22/07/2023', city: 'Rio de Janeiro', location: 'Jeunesse Arena', tickets: 'https://example.com/tickets2', map: 'https://maps.google.com/?q=Jeunesse+Arena' },
    { id: 3, date: '05/08/2023', city: 'Belo Horizonte', location: 'Mineirão', tickets: 'https://example.com/tickets3', map: 'https://maps.google.com/?q=Mineirao' },
    { id: 4, date: '12/08/2023', city: 'Porto Alegre', location: 'Arena do Grêmio', tickets: 'https://example.com/tickets4', map: 'https://maps.google.com/?q=Arena+do+Gremio' },
  ];

  const pastShows = [
    { id: 5, date: '10/06/2023', city: 'Curitiba', location: 'Arena da Baixada' },
    { id: 6, date: '03/06/2023', city: 'Florianópolis', location: 'Arena Condá' },
  ];

  const addToCalendar = (show) => {
    const title = "Show de João Guilherme";
    const details = `Show de João Guilherme em ${show.location}, ${show.city}`;
    const startDate = show.date.split('/').reverse().join('-');
    const endDate = startDate; // Assuming same day event
    
    const googleCalendarUrl = `https://calendar.google.com/calendar/render?action=TEMPLATE&text=${encodeURIComponent(title)}&dates=${startDate}/${endDate}&details=${encodeURIComponent(details)}&location=${encodeURIComponent(show.location + ', ' + show.city)}`;
    
    window.open(googleCalendarUrl, '_blank');
  };

  return (
    <section className="py-20 bg-black-primary">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">Agenda de Shows</h2>
          <p className="text-gray-400 max-w-2xl mx-auto">As datas esgotam rápido. Garanta já!</p>
        </div>
        
        <div className="flex justify-center mb-10">
          <div className="inline-flex bg-gray-primary rounded-full p-1">
            <button
              onClick={() => setActiveTab('proximos')}
              className={`px-6 py-2 rounded-full text-sm font-medium transition-colors ${activeTab === 'proximos' ? 'bg-blue-light text-white' : 'text-gray-400 hover:text-white'}`}
            >
              Próximos Shows
            </button>
            <button
              onClick={() => setActiveTab('passados')}
              className={`px-6 py-2 rounded-full text-sm font-medium transition-colors ${activeTab === 'passados' ? 'bg-blue-light text-white' : 'text-gray-400 hover:text-white'}`}
            >
              Shows Realizados
            </button>
          </div>
        </div>
        
        {activeTab === 'proximos' ? (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {shows.map((show) => (
              <div key={show.id} className="bg-gray-primary rounded-2xl overflow-hidden shadow-lg">
                <div className="p-6">
                  <div className="flex justify-between items-start mb-4">
                    <div>
                      <div className="text-blue-light font-bold text-lg">{show.date}</div>
                      <h3 className="text-white text-xl font-semibold mt-1">{show.city}</h3>
                      <p className="text-gray-400 mt-1">{show.location}</p>
                    </div>
                    <div className="bg-blue-dark text-blue-light px-3 py-1 rounded-full text-sm font-medium">
                      Em breve
                    </div>
                  </div>
                  
                  <div className="flex flex-col sm:flex-row space-y-3 sm:space-y-0 sm:space-x-3 mt-6">
                    <a 
                      href={show.tickets} 
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="flex-1 bg-blue-light text-white px-4 py-2 rounded-lg font-medium text-center hover:bg-blue-600 transition-colors"
                    >
                      🎟 Comprar Ingressos
                    </a>
                    <button 
                      onClick={() => addToCalendar(show)}
                      className="flex-1 bg-transparent border border-blue-light text-blue-light px-4 py-2 rounded-lg font-medium hover:bg-blue-light hover:text-black-primary transition-colors"
                    >
                      Adicionar à agenda
                    </button>
                  </div>
                </div>
                
                <div className="h-48">
                  <iframe 
                    src={show.map} 
                    width="100%" 
                    height="100%" 
                    style={{ border: 0 }}
                    allowFullScreen="" 
                    loading="lazy" 
                    referrerPolicy="no-referrer-when-downgrade"
                    title={`Mapa de ${show.location}`}
                  ></iframe>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="bg-gray-primary rounded-2xl overflow-hidden shadow-lg">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-black-primary">
                  <tr>
                    <th className="py-4 px-6 text-left text-gray-400 font-medium">Data</th>
                    <th className="py-4 px-6 text-left text-gray-400 font-medium">Cidade</th>
                    <th className="py-4 px-6 text-left text-gray-400 font-medium">Local</th>
                  </tr>
                </thead>
                <tbody>
                  {pastShows.map((show) => (
                    <tr key={show.id} className="border-b border-gray-800 last:border-0">
                      <td className="py-4 px-6 text-white">{show.date}</td>
                      <td className="py-4 px-6 text-white">{show.city}</td>
                      <td className="py-4 px-6 text-white">{show.location}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}
        
        <div className="text-center mt-12">
          <a 
            href="#agenda-completa" 
            className="inline-flex items-center text-blue-light hover:text-blue-400 font-medium"
          >
            Ver Agenda Completa
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 ml-1" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clipRule="evenodd" />
            </svg>
          </a>
        </div>
      </div>
    </section>
  );
}
EOF

# Componente Contratacao
cat > src/components/Contratacao.tsx << 'EOF'
import { useState } from 'react';

export default function Contratacao() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    eventType: '',
    eventDate: '',
    location: '',
    estimatedAudience: '',
    message: ''
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    
    // Format message for WhatsApp
    const message = `Olá, gostaria de solicitar um orçamento para um show do João Guilherme.%0A%0A*Nome:* ${formData.name}%0A*E-mail:* ${formData.email}%0A*Telefone:* ${formData.phone}%0A*Tipo de Evento:* ${formData.eventType}%0A*Data do Evento:* ${formData.eventDate}%0A*Local:* ${formData.location}%0A*Público Estimado:* ${formData.estimatedAudience}%0A*Mensagem:* ${formData.message}`;
    
    // Open WhatsApp with pre-filled message
    window.open(`https://wa.me/5511999999999?text=${message}`, '_blank');
  };

  return (
    <section className="py-20 bg-gray-primary">
      <div className="container mx-auto px-4">
        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">Contratação</h2>
            <p className="text-gray-400 max-w-2xl mx-auto">Transforme seu evento em um show inesquecível. Mais de 100 eventos realizados com sucesso.</p>
          </div>
          
          <div className="bg-black-primary rounded-2xl p-8 shadow-xl">
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label htmlFor="name" className="block text-gray-400 mb-2">Nome Completo</label>
                  <input
                    type="text"
                    id="name"
                    name="name"
                    value={formData.name}
                    onChange={handleChange}
                    required
                    className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                  />
                </div>
                
                <div>
                  <label htmlFor="email" className="block text-gray-400 mb-2">E-mail</label>
                  <input
                    type="email"
                    id="email"
                    name="email"
                    value={formData.email}
                    onChange={handleChange}
                    required
                    className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                  />
                </div>
                
                <div>
                  <label htmlFor="phone" className="block text-gray-400 mb-2">Telefone</label>
                  <input
                    type="tel"
                    id="phone"
                    name="phone"
                    value={formData.phone}
                    onChange={handleChange}
                    required
                    className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                  />
                </div>
                
                <div>
                  <label htmlFor="eventType" className="block text-gray-400 mb-2">Tipo de Evento</label>
                  <select
                    id="eventType"
                    name="eventType"
                    value={formData.eventType}
                    onChange={handleChange}
                    required
                    className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                  >
                    <option value="">Selecione</option>
                    <option value="show">Show</option>
                    <option value="festival">Festival</option>
                    <option value="corporate">Evento Corporativo</option>
                    <option value="private">Evento Privado</option>
                    <option value="wedding">Casamento</option>
                    <option value="other">Outro</option>
                  </select>
                </div>
                
                <div>
                  <label htmlFor="eventDate" className="block text-gray-400 mb-2">Data do Evento</label>
                  <input
                    type="date"
                    id="eventDate"
                    name="eventDate"
                    value={formData.eventDate}
                    onChange={handleChange}
                    required
                    className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                  />
                </div>
                
                <div>
                  <label htmlFor="location" className="block text-gray-400 mb-2">Local</label>
                  <input
                    type="text"
                    id="location"
                    name="location"
                    value={formData.location}
                    onChange={handleChange}
                    required
                    className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                  />
                </div>
              </div>
              
              <div>
                <label htmlFor="estimatedAudience" className="block text-gray-400 mb-2">Público Estimado</label>
                <input
                  type="text"
                  id="estimatedAudience"
                  name="estimatedAudience"
                  value={formData.estimatedAudience}
                  onChange={handleChange}
                  placeholder="Ex: 500 pessoas"
                  className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                />
              </div>
              
              <div>
                <label htmlFor="message" className="block text-gray-400 mb-2">Mensagem</label>
                <textarea
                  id="message"
                  name="message"
                  value={formData.message}
                  onChange={handleChange}
                  rows={4}
                  className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                ></textarea>
              </div>
              
              <div className="pt-4">
                <button
                  type="submit"
                  className="w-full bg-blue-light text-white px-8 py-4 rounded-lg font-semibold hover:bg-blue-600 transition-colors"
                >
                  Solicitar Orçamento Agora
                </button>
                <p className="text-gray-500 text-sm mt-3 text-center">
                  Garanta Sua Data - Agende com antecedência
                </p>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  );
}
EOF

# Componente FanClub
cat > src/components/FanClub.tsx << 'EOF'
import { useState } from 'react';

export default function FanClub() {
  const [email, setEmail] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    // Simulate API call to Mailchimp
    setTimeout(() => {
      setIsSubmitting(false);
      setSubmitted(true);
      setEmail('');
      
      // Reset success message after 5 seconds
      setTimeout(() => setSubmitted(false), 5000);
    }, 1500);
  };

  return (
    <section className="py-20 bg-gradient-to-r from-blue-dark to-black-primary">
      <div className="container mx-auto px-4">
        <div className="max-w-4xl mx-auto">
          <div className="flex flex-col md:flex-row items-center">
            <div className="md:w-1/2 mb-10 md:mb-0">
              <div className="relative">
                <div className="absolute -inset-4 bg-blue-light rounded-full opacity-20 blur-xl"></div>
                <img 
                  src="/sitemeu/images/fan-club.jpg" 
                  alt="Fã Clube VIP João Guilherme" 
                  className="relative rounded-2xl shadow-2xl w-full"
                />
              </div>
            </div>
            
            <div className="md:w-1/2 md:pl-12">
              <div className="bg-black-primary bg-opacity-70 backdrop-blur-sm rounded-2xl p-8 shadow-xl">
                <h2 className="text-3xl font-bold text-white mb-4">Fã Clube VIP</h2>
                <p className="text-gray-300 mb-6">Seja parte do time que está mais perto de João Guilherme.</p>
                
                <div className="space-y-4 mb-8">
                  <div className="flex items-start">
                    <div className="flex-shrink-0 mt-1">
                      <div className="w-6 h-6 rounded-full bg-blue-light flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-black-primary" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                      </div>
                    </div>
                    <div className="ml-3">
                      <h3 className="text-white font-medium">Acesso antecipado</h3>
                      <p className="text-gray-400 text-sm">Compre ingressos antes do público geral</p>
                    </div>
                  </div>
                  
                  <div className="flex items-start">
                    <div className="flex-shrink-0 mt-1">
                      <div className="w-6 h-6 rounded-full bg-blue-light flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-black-primary" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                      </div>
                    </div>
                    <div className="ml-3">
                      <h3 className="text-white font-medium">Brindes exclusivos</h3>
                      <p className="text-gray-400 text-sm">Receba produtos personalizados e edições limitadas</p>
                    </div>
                  </div>
                  
                  <div className="flex items-start">
                    <div className="flex-shrink-0 mt-1">
                      <div className="w-6 h-6 rounded-full bg-blue-light flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-black-primary" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                      </div>
                    </div>
                    <div className="ml-3">
                      <h3 className="text-white font-medium">Conteúdo exclusivo</h3>
                      <p className="text-gray-400 text-sm">Acesse bastidores, entrevistas e vídeos exclusivos</p>
                    </div>
                  </div>
                </div>
                
                {submitted ? (
                  <div className="bg-green-900 bg-opacity-30 border border-green-500 rounded-lg p-4 text-center">
                    <div className="text-green-400 font-medium">Inscrição realizada com sucesso!</div>
                    <p className="text-green-300 text-sm mt-1">Verifique seu e-mail para confirmar.</p>
                  </div>
                ) : (
                  <form onSubmit={handleSubmit} className="space-y-4">
                    <div>
                      <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        placeholder="Seu melhor e-mail"
                        required
                        className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                      />
                    </div>
                    <button
                      type="submit"
                      disabled={isSubmitting}
                      className="w-full bg-blue-light text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-600 transition-colors flex items-center justify-center disabled:opacity-70"
                    >
                      {isSubmitting ? (
                        <>
                          <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                          </svg>
                          Processando...
                        </>
                      ) : (
                        <>
                          <span className="mr-2">🎁</span> Entrar para o Fã Clube VIP
                        </>
                      )}
                    </button>
                    <p className="text-gray-500 text-sm text-center">
                      Seja VIP e receba conteúdos exclusivos.
                    </p>
                  </form>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
EOF

# Componente Blog
cat > src/components/Blog.tsx << 'EOF'
import Link from 'next/link';

export default function Blog() {
  const posts = [
    {
      id: 1,
      title: "Nos bastidores do novo clipe",
      excerpt: "Confira os detalhes da produção do mais novo lançamento de João Guilherme",
      image: "/sitemeu/images/blog1.jpg",
      date: "15 de Junho, 2023",
      author: "Equipe João Guilherme"
    },
    {
      id: 2,
      title: "A jornada musical: dos primórdios ao sucesso",
      excerpt: "Como João Guilherme construiu sua carreira e se tornou uma das principais vozes do sertanejo pop",
      image: "/sitemeu/images/blog2.jpg",
      date: "02 de Junho, 2023",
      author: "Redação"
    },
    {
      id: 3,
      title: "5 curiosidades sobre João Guilherme",
      excerpt: "Coisas que você provavelmente não sabia sobre o cantor e compositor",
      image: "/sitemeu/images/blog3.jpg",
      date: "20 de Maio, 2023",
      author: "Redação"
    }
  ];

  return (
    <section className="py-20 bg-black-primary">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">Blog</h2>
          <p className="text-gray-400 max-w-2xl mx-auto">Acompanhe as novidades e os bastidores da carreira de João Guilherme</p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {posts.map((post) => (
            <div key={post.id} className="bg-gray-primary rounded-2xl overflow-hidden shadow-lg hover:shadow-xl transition-shadow">
              <div className="h-48 overflow-hidden">
                <img 
                  src={post.image} 
                  alt={post.title} 
                  className="w-full h-full object-cover hover:scale-105 transition-transform duration-500"
                />
              </div>
              <div className="p-6">
                <div className="text-gray-500 text-sm mb-2">{post.date} • {post.author}</div>
                <h3 className="text-xl font-semibold text-white mb-3">{post.title}</h3>
                <p className="text-gray-400 mb-4">{post.excerpt}</p>
                <Link 
                  href={`/blog/${post.id}`}
                  className="text-blue-light hover:text-blue-400 font-medium flex items-center"
                >
                  Ler mais
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 ml-1" viewBox="0 0 20 20" fill="currentColor">
                    <path fillRule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clipRule="evenodd" />
                  </svg>
                </Link>
              </div>
            </div>
          ))}
        </div>
        
        <div className="text-center mt-12">
          <Link 
            href="/blog"
            className="inline-flex items-center bg-blue-light text-white px-6 py-3 rounded-full font-semibold hover:bg-blue-600 transition-colors"
          >
            Explorar Bastidores
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clipRule="evenodd" />
            </svg>
          </Link>
        </div>
      </div>
    </section>
  );
}
EOF

# Componente Patrocinadores
cat > src/components/Patrocinadores.tsx << 'EOF'
import Link from 'next/link';

export default function Patrocinadores() {
  const sponsors = [
    { id: 1, name: "Empresa A", logo: "/sitemeu/images/sponsor1.png" },
    { id: 2, name: "Empresa B", logo: "/sitemeu/images/sponsor2.png" },
    { id: 3, name: "Empresa C", logo: "/sitemeu/images/sponsor3.png" },
    { id: 4, name: "Empresa D", logo: "/sitemeu/images/sponsor4.png" },
    { id: 5, name: "Empresa E", logo: "/sitemeu/images/sponsor5.png" },
    { id: 6, name: "Empresa F", logo: "/sitemeu/images/sponsor6.png" }
  ];

  return (
    <section className="py-20 bg-gray-primary">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">Parceiros</h2>
          <p className="text-gray-400 max-w-2xl mx-auto">Fortaleça sua marca ao lado de João Guilherme</p>
        </div>
        
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-8 mb-12">
          {sponsors.map((sponsor) => (
            <div key={sponsor.id} className="flex items-center justify-center bg-black-primary rounded-xl p-6 hover:bg-blue-dark transition-colors">
              <img 
                src={sponsor.logo} 
                alt={sponsor.name} 
                className="max-h-16 max-w-full filter grayscale hover:grayscale-0 transition-all"
              />
            </div>
          ))}
        </div>
        
        <div className="text-center">
          <Link 
            href="/seja-parceiro"
            className="inline-flex items-center bg-blue-light text-white px-6 py-3 rounded-full font-semibold hover:bg-blue-600 transition-colors"
          >
            <span className="mr-2">💼</span> Seja um Parceiro
          </Link>
        </div>
      </div>
    </section>
  );
}
EOF

# Componente Chatbot
cat > src/components/Chatbot.tsx << 'EOF'
import { useState, useEffect, useRef } from 'react';

export default function Chatbot() {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState([
    { id: 1, text: "Oi! Sou o JoãoBot, posso te ajudar?", sender: 'bot' }
  ]);
  const [inputValue, setInputValue] = useState('');
  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSendMessage = () => {
    if (inputValue.trim() === '') return;
    
    // Add user message
    const newUserMessage = {
      id: messages.length + 1,
      text: inputValue,
      sender: 'user'
    };
    
    setMessages([...messages, newUserMessage]);
    setInputValue('');
    
    // Simulate bot response after delay
    setTimeout(() => {
      const botResponses = [
        "Posso te ajudar com informações sobre shows, música ou como entrar em contato com a equipe do João Guilherme.",
        "Para saber sobre a agenda de shows, visite a seção Agenda aqui no site.",
        "Você pode ouvir as músicas do João Guilherme no Spotify, Apple Music e outras plataformas.",
        "Para contratações, preencha o formulário na seção Contratação ou fale diretamente pelo WhatsApp.",
        "Quer ser um fã VIP? Inscreva-se na seção Fã Clube VIP para receber conteúdos exclusivos!"
      ];
      
      const randomResponse = botResponses[Math.floor(Math.random() * botResponses.length)];
      
      const newBotMessage = {
        id: messages.length + 2,
        text: randomResponse,
        sender: 'bot'
      };
      
      setMessages(prev => [...prev, newBotMessage]);
    }, 1000);
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      handleSendMessage();
    }
  };

  return (
    <>
      {/* Chat Button */}
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="fixed bottom-6 right-6 w-16 h-16 rounded-full bg-blue-light text-white flex items-center justify-center shadow-lg hover:bg-blue-600 transition-colors z-40"
      >
        {isOpen ? (
          <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
          </svg>
        ) : (
          <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
          </svg>
        )}
      </button>
      
      {/* Chat Window */}
      {isOpen && (
        <div className="fixed bottom-24 right-6 w-80 h-96 bg-black-primary rounded-2xl shadow-2xl flex flex-col z-50 border border-gray-800">
          {/* Header */}
          <div className="bg-blue-dark p-4 rounded-t-2xl flex items-center">
            <div className="w-10 h-10 rounded-full bg-blue-light flex items-center justify-center mr-3">
              <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 text-black-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z" />
              </svg>
            </div>
            <div>
              <h3 className="text-white font-semibold">JoãoBot</h3>
              <p className="text-gray-400 text-xs">Assistente virtual</p>
            </div>
          </div>
          
          {/* Messages */}
          <div className="flex-1 overflow-y-auto p-4 space-y-4">
            {messages.map((message) => (
              <div
                key={message.id}
                className={`flex ${message.sender === 'user' ? 'justify-end' : 'justify-start'}`}
              >
                <div
                  className={`max-w-[80%] rounded-2xl px-4 py-2 ${
                    message.sender === 'user'
                      ? 'bg-blue-light text-black-primary rounded-br-none'
                      : 'bg-gray-primary text-white rounded-bl-none'
                  }`}
                >
                  {message.text}
                </div>
              </div>
            ))}
            <div ref={messagesEndRef} />
          </div>
          
          {/* Input */}
          <div className="p-4 border-t border-gray-800">
            <div className="flex">
              <input
                type="text"
                value={inputValue}
                onChange={(e) => setInputValue(e.target.value)}
                onKeyPress={handleKeyPress}
                placeholder="Digite sua mensagem..."
                className="flex-1 bg-gray-primary text-white rounded-l-lg px-4 py-2 focus:outline-none"
              />
              <button
                onClick={handleSendMessage}
                className="bg-blue-light text-black-primary rounded-r-lg px-4 py-2 hover:bg-blue-400 transition-colors"
              >
                <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M10.894 2.553a1 1 0 00-1.788 0l-7 14a1 1 0 001.169 1.409l5-1.429A1 1 0 009 15.571V11a1 1 0 112 0v4.571a1 1 0 00.725.962l5 1.428a1 1 0 001.17-1.408l-7-14z" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
EOF

# Componente Footer
cat > src/components/Footer.tsx << 'EOF'
import Link from 'next/link';

export default function Footer() {
  return (
    <footer className="bg-black-primary pt-16 pb-8">
      <div className="container mx-auto px-4">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-12">
          {/* Logo */}
          <div className="md:col-span-1">
            <Link href="/" className="text-white text-2xl font-bold mb-4 block">
              João Guilherme
            </Link>
            <p className="text-gray-400 mb-6">A nova voz do sertanejo pop</p>
            
            {/* Social Media */}
            <div className="flex space-x-4">
              <a href="https://instagram.com/joaoguilherme" target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">
                <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fillRule="evenodd" d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.45 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748.353.137.882.3 1.857.344 1.054.048 1.37.058 4.041.058h.08c2.597 0 2.917-.01 3.96-.058.976-.045 1.505-.207 1.858-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.055.058-1.37.058-4.041v-.08c0-2.597-.01-2.917-.058-3.96-.045-.976-.207-1.505-.344-1.858a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z" clipRule="evenodd" />
                </svg>
              </a>
              <a href="https://youtube.com/joaoguilherme" target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">
                <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fillRule="evenodd" d="M19.812 5.418c.861.23 1.538.907 1.768 1.768C21.998 8.746 22 12 22 12s0 3.255-.418 4.814a2.504 2.504 0 0 1-1.768 1.768c-1.56.419-7.814.419-7.814.419s-6.255 0-7.814-.419a2.505 2.505 0 0 1-1.768-1.768C2 15.255 2 12 2 12s0-3.255.417-4.814a2.507 2.507 0 0 1 1.768-1.768C5.744 5 11.998 5 11.998 5s6.255 0 7.814.418ZM15.194 12 10 15V9l5.194 3Z" clipRule="evenodd" />
                </svg>
              </a>
              <a href="https://open.spotify.com/artist/ID" target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">
                <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M12 0C5.4 0 0 5.4 0 12s5.4 12 12 12 12-5.4 12-12S18.66 0 12 0zm5.521 17.34c-.24.359-.66.48-1.021.24-2.82-1.74-6.36-2.101-10.561-1.141-.418.122-.779-.179-.899-.539-.12-.421.18-.78.54-.9 4.56-1.021 8.52-.6 11.64 1.32.42.18.479.659.301 1.02zm1.44-3.3c-.301.42-.841.6-1.262.3-3.239-1.98-8.159-2.58-11.939-1.38-.479.12-1.02-.12-1.14-.6-.12-.48.12-1.021.6-1.141C9.6 9.9 15 10.561 18.72 12.84c.361.181.54.78.241 1.2zm.12-3.36C15.24 8.4 8.82 8.16 5.16 9.301c-.601.18-1.239-.181-1.419-.721-.18-.601.18-1.239.72-1.419 4.26-1.26 11.28-1.02 15.721 1.619.539.3.719 1.02.419 1.56-.299.421-1.02.599-1.559.3z" />
                </svg>
              </a>
            </div>
          </div>
          
          {/* Quick Links */}
          <div>
            <h3 className="text-white font-semibold mb-4">Links Rápidos</h3>
            <ul className="space-y-2">
              <li>
                <Link href="#agenda" className="text-gray-400 hover:text-white transition-colors">Agenda</Link>
              </li>
              <li>
                <Link href="#contato" className="text-gray-400 hover:text-white transition-colors">Contato</Link>
              </li>
              <li>
                <Link href="/blog" className="text-gray-400 hover:text-white transition-colors">Blog</Link>
              </li>
              <li>
                <Link href="#contratacao" className="text-gray-400 hover:text-white transition-colors">Contratação</Link>
              </li>
            </ul>
          </div>
          
          {/* Music */}
          <div>
            <h3 className="text-white font-semibold mb-4">Músicas</h3>
            <ul className="space-y-2">
              <li>
                <a href="https://open.spotify.com/artist/ID" target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">Spotify</a>
              </li>
              <li>
                <a href="https://music.apple.com/artist/ID" target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">Apple Music</a>
              </li>
              <li>
                <a href="https://www.youtube.com/channel/ID" target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">YouTube</a>
              </li>
              <li>
                <a href="https://www.deezer.com/artist/ID" target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">Deezer</a>
              </li>
            </ul>
          </div>
          
          {/* Contact */}
          <div>
            <h3 className="text-white font-semibold mb-4">Contato</h3>
            <ul className="space-y-2">
              <li className="text-gray-400">
                <a href="mailto:contato@joaoguilherme.com" className="hover:text-white transition-colors">contato@joaoguilherme.com</a>
              </li>
              <li className="text-gray-400">
                <a href="tel:+5511999999999" className="hover:text-white transition-colors">+55 11 99999-9999</a>
              </li>
              <li className="text-gray-400">
                <a href="https://wa.me/5511999999999" target="_blank" rel="noopener noreferrer" className="hover:text-white transition-colors">WhatsApp</a>
              </li>
            </ul>
          </div>
        </div>
        
        {/* Bottom */}
        <div className="pt-8 border-t border-gray-800 text-center text-gray-500 text-sm">
          <p>&copy; {new Date().getFullYear()} João Guilherme. Todos os direitos reservados.</p>
          <div className="mt-2">
            <Link href="/politica-de-privacidade" className="hover:text-white transition-colors">Política de Privacidade</Link>
            {' • '}
            <Link href="/termos-de-uso" className="hover:text-white transition-colors">Termos de Uso</Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
EOF
success "Componentes criados!"

# Criar arquivos de configuração do Firebase
status "Configurando Firebase..."
cat > src/lib/firebase.ts << 'EOF'
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';
import { getMessaging, getToken, onMessage } from 'firebase/messaging';

const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY,
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID,
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);
const messaging = getMessaging(app);

export { auth, db, messaging };

// Request permission for notifications
export const requestNotificationPermission = async () => {
  try {
    const permission = await Notification.requestPermission();
    if (permission === 'granted') {
      const token = await getToken(messaging, { vapidKey: process.env.NEXT_PUBLIC_FIREBASE_VAPID_KEY });
      return token;
    } else {
      console.log('Notification permission denied');
      return null;
    }
  } catch (error) {
    console.error('Error requesting notification permission:', error);
    return null;
  }
};

// Listen for foreground messages
export const onMessageListener = () => {
  return new Promise((resolve) => {
    onMessage(messaging, (payload) => {
      resolve(payload);
    });
  });
};
EOF
success "Configuração do Firebase criada!"

# Criar arquivos de integração
status "Configurando integrações..."

# Mailchimp
cat > src/lib/mailchimp.ts << 'EOF'
import mailchimp from '@mailchimp/mailchimp_marketing';

mailchimp.setConfig({
  apiKey: process.env.NEXT_PUBLIC_MAILCHIMP_API_KEY,
  server: process.env.NEXT_PUBLIC_MAILCHIMP_SERVER_PREFIX,
});

export const subscribeToNewsletter = async (email: string) => {
  try {
    const response = await mailchimp.lists.addListMember(
      process.env.NEXT_PUBLIC_MAILCHIMP_LIST_ID!,
      {
        email_address: email,
        status: 'subscribed',
      }
    );
    return response;
  } catch (error) {
    throw error;
  }
};
EOF

# WhatsApp
cat > src/lib/whatsapp.ts << 'EOF'
export const sendWhatsAppMessage = (phoneNumber: string, message: string) => {
  const url = `https://wa.me/${phoneNumber.replace(/\D/g, '')}?text=${encodeURIComponent(message)}`;
  window.open(url, '_blank');
};
EOF

# Google Analytics
cat > src/lib/analytics.ts << 'EOF'
export const pageview = (url: string) => {
  if (typeof window !== 'undefined') {
    window.gtag('config', 'GA_MEASUREMENT_ID', {
      page_path: url,
    });
  }
};

export const event = ({ action, category, label, value }: {
  action: string;
  category: string;
  label?: string;
  value?: number;
}) => {
  if (typeof window !== 'undefined') {
    window.gtag('event', action, {
      event_category: category,
      event_label: label,
      value: value,
    });
  }
};
EOF

# Meta Pixel
cat > src/lib/meta-pixel.ts << 'EOF'
export const pageView = () => {
  if (typeof window !== 'undefined') {
    window.fbq('track', 'PageView');
  }
};

export const event = (eventName: string, options: Record<string, any> = {}) => {
  if (typeof window !== 'undefined') {
    window.fbq('track', eventName, options);
  }
};
EOF

# Notificações
cat > src/lib/notifications.ts << 'EOF'
import { messaging } from './firebase';

export const requestNotificationPermission = async () => {
  try {
    const permission = await Notification.requestPermission();
    if (permission === 'granted') {
      const token = await messaging.getToken({
        vapidKey: process.env.NEXT_PUBLIC_FIREBASE_VAPID_KEY,
      });
      return token;
    } else {
      console.log('Notification permission denied');
      return null;
    }
  } catch (error) {
    console.error('Error requesting notification permission:', error);
    return null;
  }
};

export const onMessageListener = () => {
  return new Promise((resolve) => {
    messaging.onMessage((payload) => {
      resolve(payload);
    });
  });
};
EOF
success "Integrações configuradas!"

# Criar arquivo de workflow do GitHub Actions
status "Configurando GitHub Actions..."
cat > .github/workflows/deploy.yml << 'EOF'
name: Deploy static content to Pages
on:
  # Runs on pushes targeting the default branch
  push:
    branches: ["main"]
  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:
# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write
# Allow only one concurrent deployment, skipping runs queued between the run in-progress and latest queued.
# However, do NOT cancel in-progress runs as we want to allow these production deployments to complete.
concurrency:
  group: "pages"
  cancel-in-progress: false
jobs:
  # Single deploy job since we're just deploying
  deploy:
    environment:
      name: github-pages
      url: \${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Pages
        uses: actions/configure-pages@v5
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          # Upload entire repository
          path: '.'
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF
success "Workflow do GitHub Actions configurado!"

# Criar arquivos PWA
status "Configurando PWA..."

# Manifest
cat > public/manifest.json << 'EOF'
{
  "name": "João Guilherme - Site Oficial",
  "short_name": "João Guilherme",
  "description": "A nova voz do sertanejo pop",
  "start_url": "/sitemeu/",
  "display": "standalone",
  "background_color": "#0B0B0B",
  "theme_color": "#2E86DE",
  "icons": [
    {
      "src": "/sitemeu/images/icon-192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/sitemeu/images/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
EOF

# Service Worker
cat > public/sw.js << 'EOF'
const CACHE_NAME = 'joao-guilherme-cache-v1';
const urlsToCache = [
  '/sitemeu/',
  '/sitemeu/manifest.json',
  '/sitemeu/favicon.ico',
  '/sitemeu/images/joao-guilherme-hero.jpg',
  '/sitemeu/images/fan-club.jpg',
  '/sitemeu/images/blog1.jpg',
  '/sitemeu/images/blog2.jpg',
  '/sitemeu/images/blog3.jpg',
  '/sitemeu/images/sponsor1.png',
  '/sitemeu/images/sponsor2.png',
  '/sitemeu/images/sponsor3.png',
  '/sitemeu/images/sponsor4.png',
  '/sitemeu/images/sponsor5.png',
  '/sitemeu/images/sponsor6.png',
  '/sitemeu/images/video1.jpg',
  '/sitemeu/images/video2.jpg',
  '/sitemeu/images/video3.jpg',
  '/sitemeu/images/video4.jpg',
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        return cache.addAll(urlsToCache);
      })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        return response || fetch(event.request);
      })
  );
});

self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
EOF
success "Arquivos PWA criados!"

# Criar README
status "Criando README..."
cat > README.md << 'EOF'
# João Guilherme - Site Oficial

Site oficial do cantor sertanejo/pop João Guilherme.

## Tecnologias Utilizadas

- [Next.js](https://nextjs.org/) - Framework React
- [Tailwind CSS](https://tailwindcss.com/) - Framework CSS
- [TypeScript](https://www.typescriptlang.org/) - Linguagem de tipagem
- [Firebase](https://firebase.google.com/) - Banco de dados e autenticação
- [GitHub Pages](https://pages.github.com/) - Hospedagem

## Funcionalidades

- Site responsivo e otimizado para SEO
- Integração com Spotify e Apple Music
- Agenda de shows interativa
- Formulário de contratação
- Fã Clube VIP com captura de e-mails
- Blog com artigos
- Chatbot de IA
- Notificações push
- PWA (Progressive Web App)

## Como Executar Localmente

1. Clone este repositório
2. Instale as dependências: \`npm install\`
3. Execute o servidor de desenvolvimento: \`npm run dev\`
4. Acesse \`http://localhost:3000\` no seu navegador

## Como Contribuir

1. Faça um fork deste repositório
2. Crie uma branch para sua feature: \`git checkout -b feature/nova-feature\`
3. Commit suas mudanças: \`git commit -am 'Adiciona nova feature'\`
4. Push para a branch: \`git push origin feature/nova-feature\`
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.
EOF
success "README criado!"

# Criar .gitignore
status "Criando .gitignore..."
cat > .gitignore << 'EOF'
# dependencies
/node_modules
/.pnp
.pnp.js

# testing
/coverage

# next.js
/.next/
/out/

# production
/build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnpm-debug.log*

# local env files
.env*.local

# vercel
.vercel

# typescript
*.tsbuildinfo
next-env.d.ts
EOF
success ".gitignore criado!"

# Fazer commit inicial
status "Fazendo commit inicial..."
git add .
git commit -m "Initial commit: Site do João Guilherme"
success "Commit inicial realizado!"

# Exibir instruções finais
echo ""
success "Site do João Guilherme criado com sucesso!"
echo ""
status "Próximos passos:"
echo "1. Adicione as imagens na pasta public/images"
echo "2. Configure as variáveis de ambiente no GitHub Secrets"
echo "3. Faça push para o repositório remoto:"
echo "   git remote add origin https://github.com/joaoguisil/sitemeu.git"
echo "   git push -u origin main"
echo ""
echo "Após o push, o GitHub Actions irá implantar automaticamente o site em:"
echo "https://joaoguisil.github.io/sitemeu/"
