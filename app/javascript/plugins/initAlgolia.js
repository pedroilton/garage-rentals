import places from 'places.js';

const initAlgolia = () => {
  const addressInput = document.getElementById('garage_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAlgolia };