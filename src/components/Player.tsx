// src/components/Player.tsx
import { useState } from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import { Navigation, Pagination } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

export default function Player() {
  const [isPlaying, setIsPlaying] = useState(false);

  const videos = [
    { id: 1, title: "Show em São Paulo", thumbnail: "/images/video1.jpg" },
    { id: 2, title: "Clipe Oficial - Nova Música", thumbnail: "/images/video2.jpg" },
    { id: 3, title: "Entrevista Exclusiva", thumbnail: "/images/video3.jpg" },
    { id: 4, title: "Nos Estúdios de Gravação", thumbnail: "/images/video4.jpg" },
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
