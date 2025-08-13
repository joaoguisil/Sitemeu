// src/app/page.tsx
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
