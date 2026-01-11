import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["name", "company", "city", "badge", "statusText"]

    static values = {
        url: String,
        toggleUrl: String
    }

    async sync(event) {
    }

    async toggleStatus(event) {
        event.preventDefault()

        this.badgeTarget.style.opacity = "0.5"

        try {
            const token = document.querySelector('meta[name="csrf-token"]').content

            const response = await fetch(this.toggleUrlValue, {
                method: "PATCH",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-Token": token
                }
            })

            if (response.ok) {
                const data = await response.json()
                this.updateBadgeStyle(data.completed, data.status_text)
            }
        } catch (error) {
            console.error(error)
            alert("Erro ao atualizar status")
        } finally {
            this.badgeTarget.style.opacity = "1"
        }
    }

    updateBadgeStyle(isCompleted, text) {
        this.statusTextTarget.innerText = text

        if (isCompleted) {
            this.badgeTarget.classList.remove("bg-amber-100", "text-amber-700", "border-amber-200")
            this.badgeTarget.classList.add("bg-green-100", "text-green-700", "border-green-200")
        } else {
            this.badgeTarget.classList.remove("bg-green-100", "text-green-700", "border-green-200")
            this.badgeTarget.classList.add("bg-amber-100", "text-amber-700", "border-amber-200")
        }
    }
}