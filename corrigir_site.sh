#!/bin/bash

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

# Verificar se estamos no diretório correto
if [ ! -f "package.json" ]; then
    error "Este script deve ser executado no diretório raiz do projeto."
    exit 1
fi

# Remover @next/pwa do package.json se existir
status "Removendo @next/pwa do package.json..."
sed -i '/@next\/pwa/d' package.json
success "@next/pwa removido!"

# Instalar dependências corretas
status "Instalando dependências corretas..."
npm install next-pwa workbox-webpack-plugin
success "Dependências instaladas!"

# Criar pasta para imagens
status "Criando pasta para imagens..."
mkdir -p public/images
success "Pasta de imagens criada!"

# Criar imagens de placeholder
status "Criando imagens de placeholder..."
cat > public/images/joao-guilherme-hero.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real do João Guilherme
EOF

cat > public/images/fan-club.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para o fã clube
EOF

cat > public/images/blog1.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para o blog
EOF

cat > public/images/blog2.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para o blog
EOF

cat > public/images/blog3.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para o blog
EOF

cat > public/images/video1.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para os vídeos
EOF

cat > public/images/video2.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para os vídeos
EOF

cat > public/images/video3.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para os vídeos
EOF

cat > public/images/video4.jpg << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por uma imagem real para os vídeos
EOF

cat > public/images/sponsor1.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por logos reais dos patrocinadores
EOF

cat > public/images/sponsor2.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por logos reais dos patrocinadores
EOF

cat > public/images/sponsor3.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por logos reais dos patrocinadores
EOF

cat > public/images/sponsor4.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por logos reais dos patrocinadores
EOF

cat > public/images/sponsor5.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por logos reais dos patrocinadores
EOF

cat > public/images/sponsor6.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por logos reais dos patrocinadores
EOF

cat > public/images/icon-192x192.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por um ícone real de 192x192
EOF

cat > public/images/icon-512x512.png << 'EOF'
# Esta é uma imagem de placeholder
# Substitua por um ícone real de 512x512
EOF

success "Imagens de placeholder criadas!"

# Atualizar o next.config.js para usar next-pwa corretamente
status "Atualizando next.config.js..."
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const withPWA = require('next-pwa')({
  dest: 'public',
  register: true,
  skipWaiting: true,
  disable: process.env.NODE_ENV === 'development',
});

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

module.exports = withPWA(nextConfig);
EOF
success "next.config.js atualizado!"

# Criar arquivo .env.example
status "Criando arquivo .env.example..."
cat > .env.example << 'EOF'
# Firebase
NEXT_PUBLIC_FIREBASE_API_KEY=your_firebase_api_key
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_firebase_auth_domain
NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_firebase_project_id
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your_firebase_storage_bucket
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_firebase_messaging_sender_id
NEXT_PUBLIC_FIREBASE_APP_ID=your_firebase_app_id
NEXT_PUBLIC_FIREBASE_VAPID_KEY=your_firebase_vapid_key

# Mailchimp
NEXT_PUBLIC_MAILCHIMP_API_KEY=your_mailchimp_api_key
NEXT_PUBLIC_MAILCHIMP_SERVER_PREFIX=your_mailchimp_server_prefix
NEXT_PUBLIC_MAILCHIMP_LIST_ID=your_mailchimp_list_id

# Analytics
NEXT_PUBLIC_GA_MEASUREMENT_ID=your_ga_measurement_id
NEXT_PUBLIC_FACEBOOK_PIXEL_ID=your_facebook_pixel_id
EOF
success "Arquivo .env.example criado!"

# Fazer commit das alterações
status "Fazendo commit das alterações..."
git add .
git commit -m "Correção: Removido @next/pwa e adicionado next-pwa, criadas imagens de placeholder"
success "Commit realizado!"

# Exibir instruções finais
echo ""
success "Correções aplicadas com sucesso!"
echo ""
status "Próximos passos:"
echo "1. Substitua as imagens de placeholder na pasta public/images"
echo "2. Configure as variáveis de ambiente no GitHub Secrets"
echo "3. Faça push para o repositório remoto:"
echo "   git remote add origin https://github.com/joaoguisil/sitemeu.git"
echo "   git push -u origin main"
echo ""
echo "Após o push, o GitHub Actions irá implantar automaticamente o site em:"
echo "https://joaoguisil.github.io/sitemeu/"
echo ""
warning "Importante: Não se esqueça de:"
echo "- Configurar as variáveis de ambiente no GitHub Secrets"
echo "- Substituir todas as imagens de placeholder por imagens reais"
echo "- Atualizar os links do Spotify, Apple Music e outras plataformas"
echo "- Configurar o Firebase para o projeto"
echo "- Configurar o Mailchimp para captura de e-mails"
