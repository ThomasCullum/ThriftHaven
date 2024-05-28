import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

// Connects to data-controller="line-charts"
export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    console.log("connected")
    const canva = this.canvasTarget;
    console.log(this.canvasTarget)

    const worldPopulationGrowth = {
      "2020": 7794798739,
      "2019": 7764951032,
      "2018": 7683789828,
      "2017": 7599822404,
      "2016": 7513474238,
      "2015": 7426597537,
      "2014": 7339013419,
      "2013": 7250593370,
      "2012": 7161697921,
      "2011": 7073125425,
      "2010": 6985603105
    };

    const labels = Object.keys(worldPopulationGrowth);
    const data = Object.values(worldPopulationGrowth);

    new Chart(canva, {
      type: 'line',
      data: {
        labels: labels,
        datasets: [{
          label: 'World Population Growth',
          data: data,
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1
        }]
      }
    });
  }
}
