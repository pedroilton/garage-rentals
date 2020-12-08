import Typed from 'typed.js'

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["CHOOSE THE PERFECT GARAGE FOR YOU ...", ";)"],
    typeSpeed: 60,
    loop: true
  });
}

export { loadDynamicBannerText };