// Common types shared between web app and extension
export interface JobPosting {
  id: string
  title: string
  company: string
  description: string
  url: string
  datePosted: Date
}