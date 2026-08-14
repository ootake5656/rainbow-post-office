import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.timer = null
    this.composing = false
    this.saving = false
    this.saveQueued = false
    this.lastSavedContent = this.element.value
  }

  disconnect() {
    this.cancelScheduledSave()
  }

  schedule() {
    if (this.composing) return

    this.cancelScheduledSave()
    this.timer = setTimeout(() => this.save(), 1000)
  }

  startComposition() {
    this.composing = true
    this.cancelScheduledSave()
  }

  finishComposition() {
    this.composing = false
    this.schedule()
  }

  async save() {
    this.cancelScheduledSave()

    const content = this.element.value
    if (content === this.lastSavedContent) return
    if (this.saving) {
      this.saveQueued = true
      return
    }

    this.saving = true

    try {
      const response = await fetch(this.urlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
          Accept: "application/json"
        },
        body: JSON.stringify({ letter: { content } })
      })

      if (response.ok) this.lastSavedContent = content
    } catch (error) {
      console.error("Failed to save letter draft", error)
    } finally {
      this.saving = false

      if (this.saveQueued) {
        this.saveQueued = false
        this.save()
      }
    }
  }

  cancelScheduledSave() {
    if (!this.timer) return

    clearTimeout(this.timer)
    this.timer = null
  }
}
