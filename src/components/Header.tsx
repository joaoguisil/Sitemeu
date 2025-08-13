// src/components/Header.tsx
import { useState } from 'react';
import Link from 'next/link';

export default function Header() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <header className="fixed top-0 w-full bg-gradient-to-r from-black-primary to-blue-dark z-50 shadow-lg">
      <div className="container mx-auto px-4 py-3 flex justify-between items-center">
        <div className="text-white text-2xl font-bold">João Guilherme</div>
        
        {/* Desktop Menu */}
        <nav className="hidden md:flex space-x-8">
          {['Início', 'Agenda', 'Músicas', 'Contratação', 'Blog', 'Contato'].map((item) => (
            <Link key={item} href={`#${item.toLowerCase()}`} className="text-white hover:text-blue-light transition-colors">
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
