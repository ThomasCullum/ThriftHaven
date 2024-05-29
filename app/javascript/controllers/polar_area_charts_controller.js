import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

// Connects to data-controller="polar-area-charts"
export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    console.log("connected")
    const canva = this.canvasTarget;

    const worldReligions = {
      "christianity": 2382000000,
      "islam": 1907000000,
      "secular": 1193000000,
      "hinduism": 1161000000
    };

    const labels = Object.keys(worldReligions);
    const data = Object.values(worldReligions);

    new Chart(canva, {
      type: 'polarArea',
      data: {
        labels: labels,
        datasets: [{
          data: data,
          backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(54, 162, 235)',
            'rgba(255, 205, 86)',
            'rgba(75, 192, 192)',
            'rgba(153, 102, 255)',
            'rgba(255, 159, 64)',
            'rgba(255, 99, 132)',
            'rgba(54, 162, 235)',
            'rgba(255, 205, 86)',
            'rgba(75, 192, 192)'
          ],
          hoverOffset: 4
        }]
      }
    });
  }
}
