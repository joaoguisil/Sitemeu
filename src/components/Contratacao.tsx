// src/components/Contratacao.tsx
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
