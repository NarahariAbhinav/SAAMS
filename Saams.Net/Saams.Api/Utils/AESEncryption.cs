﻿using System.Security.Cryptography;

namespace Saams.Api.Utils
{
    public static class AESEncryption
    {
        private static byte[] AESEncryptionKey = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
                                                   0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10,
                                                   0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
                                                   0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20 };

        public static string Encrypt(string plainText)
        {
            if (plainText == null)
            {
                throw new ArgumentNullException("plainText is null");
            }

            byte[] encrypted;

            using (var aesAlg = Aes.Create())
            {
                aesAlg.Key = AESEncryptionKey;
                aesAlg.IV = new byte[16];

                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                using (var msEncrypt = new MemoryStream())
                {
                    using (var csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (var swEncrypt = new StreamWriter(csEncrypt))
                        {
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }

            return Convert.ToHexString(encrypted);
        }

        public static string Decrypt(string cipherText)
        {
            if (cipherText == null)
            {
                throw new ArgumentNullException("cipherText is null");
            }

            byte[] encrypted = Enumerable.Range(0, cipherText.Length)
                                         .Where(x => x % 2 == 0)
                                         .Select(x => Convert.ToByte(cipherText.Substring(x, 2), 16))
                                         .ToArray();

            string? decrypted = null;

            using (var aesAlg = Aes.Create())
            {
                aesAlg.Key = AESEncryptionKey;
                aesAlg.IV = new byte[16];

                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                using (var msDecrypt = new MemoryStream(encrypted))
                {
                    using (var csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (var srDecrypt = new StreamReader(csDecrypt))
                        {
                            decrypted = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }

            return decrypted;
        }
    }
}
