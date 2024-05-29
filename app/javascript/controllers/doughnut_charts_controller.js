import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

// Connects to data-controller="doughnut-charts"
export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    console.log("connected")
    const canva = this.canvasTarget;

    const worldPopulation = {
      "men": 504,
      "women": 496
    };

    const labels = Object.keys(worldPopulation);
    const data = Object.values(worldPopulation);

    new Chart(canva, {
      type: 'doughnut',
      data: {
        labels: labels,
        datasets: [{
          data: data,
          backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(54, 162, 235)',
          ],
          hoverOffset: 4
        }]
      }
    });
  }
}
