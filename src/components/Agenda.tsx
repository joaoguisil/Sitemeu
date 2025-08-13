// src/components/Agenda.tsx
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
