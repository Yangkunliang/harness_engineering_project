import JSEncrypt from 'jsencrypt'

let publicKey = ''

export function setPublicKey(key: string) {
  publicKey = key
}

export function encryptPassword(password: string): string {
  if (!publicKey) {
    throw new Error('Public key not loaded')
  }

  const encrypt = new JSEncrypt()
  encrypt.setPublicKey(publicKey)
  return encrypt.encrypt(password) || ''
}

export function getPublicKey(): string {
  return publicKey
}
