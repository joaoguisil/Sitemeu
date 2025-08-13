// src/components/Hero.tsx
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
                src="/images/joao-guilherme-hero.jpg" 
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
